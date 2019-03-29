//
//  SHTimeZone.c
//  SHCommon
//
//  Created by Joel Pridgen on 4/14/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHTimeZone.h"
#include "SHDatetimeMod.h"
#include "SHConstants.h"
#include "SHErrorHandling.h"

static int _compareDtAndTimeShift(SHDatetime *dt,SHTimeshift *shift,int (*compare)(int64_t,int64_t)){
    SHError error;
    int64_t dtTimestamp = createDateTime_m(BASE_YEAR,dt->month,dt->day,dt->hour,dt->minute
                          ,dt->second,0,&error);
    int64_t shiftTimestamp = createDateTime_m(BASE_YEAR,shift->month,shift->day,shift->hour
                            ,shift->minute,0,0,&error);
    return compare(dtTimestamp,shiftTimestamp);
}

static int _isDtAfterShift(int64_t dt,int64_t shift){
    return dt >= shift;
}

static int _isAfterShiftCusp(SHDatetime *dt,SHTimeshift *extant){
    return _compareDtAndTimeShift(dt,extant,&_isDtAfterShift);
}

static int _isDtBeforeShift(int64_t dt,int64_t shift){
    return dt < shift;
}

static int _isBeforeShiftCusp(SHDatetime *dt,SHTimeshift *next){
    return _compareDtAndTimeShift(dt,next,&_isDtBeforeShift);
}

int shSelectTimeShiftForDt(SHDatetime *dt,SHTimeshift *shifts,int shiftCount){
    if(!(dt&&shifts)) return NOT_FOUND;
    int max = shiftCount;
    for(int i = 0;i<max;i++){
        SHTimeshift extant = shifts[i];
        int wrappedIdx = (i+1) % max;
        SHTimeshift next = shifts[wrappedIdx];
        if(_isBeforeShiftCusp(dt,&extant)){
            return ((i-1)+max) % max;
        }
        if(_isAfterShiftCusp(dt,&extant)&&_isBeforeShiftCusp(dt,&next)){
            return i;
        }
        if(_isAfterShiftCusp(dt,&next)){
            return wrappedIdx;
        }
    }
    return NOT_FOUND;
}

int shFindTimeShiftIdx(SHDatetime *dt){
    if(!dt) return NOT_FOUND;
    if(dt->shifts){
        return shSelectTimeShiftForDt(dt,dt->shifts,dt->shiftLen);
    }
    return NOT_FOUND;
}

static int _updateTimezoneForShifts(SHDatetime *dt,SHError *error){
  shLog("_updateTimezoneForShifts\n");
  if(!(dt&&error)) {
    return shHandleError(NULL_VALUES, "Null inputs", error);
  }
  if(dt->shifts){
      int oldShiftIdx = dt->currentShiftIdx;
      if(oldShiftIdx < 0 || oldShiftIdx >= dt->shiftLen){
          return INVALID_STATE;
      }
      double ts;
      SHError cnvtErr;
      shPrepareSHError(&cnvtErr);
      if(!tryDtToTimestamp_m(dt,&ts,&cnvtErr)){
        return shHandleError(cnvtErr.code,"Error in date object to"
             "timestamp in tz update",error);
      }
      int updShiftIdx = shFindTimeShiftIdx(dt);
      SHTimeshift *oldShift = &dt->shifts[oldShiftIdx];
      SHTimeshift *updShift = &dt->shifts[updShiftIdx];
      if(oldShift != updShift){
          dt->timezoneOffset -= oldShift->adjustment;
          dt->timezoneOffset += updShift->adjustment;
          int shiftCuspTS = createTime_m(updShift->hour,updShift->minute,0,&cnvtErr);
          if(cnvtErr.code){
            return shHandleError(cnvtErr.code,"Error creating time",error);
          }
          int dtTS = extractTime_m(dt,&cnvtErr);
          if(cnvtErr.code){
            return shHandleError(cnvtErr.code,"Error extracting time",error);
          }
          int shiftDif = (dtTS-shiftCuspTS);
          if(shiftDif >= HOUR_IN_SECONDS||dt->day > updShift->day||dt->month > updShift->month){
              ts += oldShift->adjustment;
              ts -= updShift->adjustment;
          }
          if(!timestampToDtUnitsOnly_m(ts,dt,&cnvtErr)){
              return shHandleError(cnvtErr.code,"Error timestampt to date"
              " time object.",error);
          }
          dt->currentShiftIdx = updShiftIdx;
          return NO_ERROR;
      }
    
  }
  return SKIP;
}

bool shUpdateTimezoneForShifts_m(SHDatetime *dt,SHError *error){
  int resultCode = _updateTimezoneForShifts(dt,error);
  return resultCode == NO_ERROR || resultCode == SKIP;
}

