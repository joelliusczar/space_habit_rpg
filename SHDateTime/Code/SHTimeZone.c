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
#include "ErrorHandling.h"

int _compareDtAndTimeShift(SHDatetime *dt,Timeshift *shift,int (*compare)(int64_t,int64_t)){
    SHError error;
    int64_t dtTimestamp = createDateTime_m(BASE_YEAR,dt->month,dt->day,dt->hour,dt->minute
                          ,dt->second,0,&error);
    int64_t shiftTimestamp = createDateTime_m(BASE_YEAR,shift->month,shift->day,shift->hour
                            ,shift->minute,0,0,&error);
    return compare(dtTimestamp,shiftTimestamp);
}

int _isDtAfterShift(int64_t dt,int64_t shift){
    return dt >= shift;
}

int _isAfterShiftCusp(SHDatetime *dt,Timeshift *extant){
    return _compareDtAndTimeShift(dt,extant,&_isDtAfterShift);
}

int _isDtBeforeShift(int64_t dt,int64_t shift){
    return dt < shift;
}

int _isBeforeShiftCusp(SHDatetime *dt,Timeshift *next){
    return _compareDtAndTimeShift(dt,next,&_isDtBeforeShift);
}

int selectTimeShiftForDt(SHDatetime *dt,Timeshift *shifts,int shiftCount){
    if(!(dt&&shifts)) return NOT_FOUND;
    int max = shiftCount;
    for(int i = 0;i<max;i++){
        Timeshift extant = shifts[i];
        int wrappedIdx = (i+1) % max;
        Timeshift next = shifts[wrappedIdx];
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

int findTimeShiftIdx(SHDatetime *dt){
    if(!dt) return NOT_FOUND;
    if(dt->shifts){
        return selectTimeShiftForDt(dt,dt->shifts,dt->shiftLen);
    }
    return NOT_FOUND;
}

int _updateTimezoneForShifts(SHDatetime *dt,SHError *error){
  SHLog("_updateTimezoneForShifts\n");
  if(!(dt&&error)) {
    return handleError(NULL_VALUES, "Null inputs", error);
  }
  if(dt->shifts){
      int oldShiftIdx = dt->currentShiftIdx;
      if(oldShiftIdx < 0 || oldShiftIdx >= dt->shiftLen){
          return INVALID_STATE;
      }
      double ts;
      SHError cnvtErr;
      setSHErrorDefault(&cnvtErr);
      if(!tryDtToTimestamp_m(dt,&ts,&cnvtErr)){
        return handleError(cnvtErr.code,"Error in date object to"
             "timestamp in tz update",error);
      }
      int updShiftIdx = findTimeShiftIdx(dt);
      Timeshift *oldShift = &dt->shifts[oldShiftIdx];
      Timeshift *updShift = &dt->shifts[updShiftIdx];
      if(oldShift != updShift){
          dt->timezoneOffset -= oldShift->adjustment;
          dt->timezoneOffset += updShift->adjustment;
          int shiftCuspTS = createTime_m(updShift->hour,updShift->minute,0,&cnvtErr);
          if(cnvtErr.code){
            return handleError(cnvtErr.code,"Error creating time",error);
          }
          int dtTS = extractTime_m(dt,&cnvtErr);
          if(cnvtErr.code){
            return handleError(cnvtErr.code,"Error extracting time",error);
          }
          int shiftDif = (dtTS-shiftCuspTS);
          if(shiftDif >= HOUR_IN_SECONDS||dt->day > updShift->day||dt->month > updShift->month){
              ts += oldShift->adjustment;
              ts -= updShift->adjustment;
          }
          if(!timestampToDtUnitsOnly_m(ts,dt,&cnvtErr)){
              return handleError(cnvtErr.code,"Error timestampt to date"
              " time object.",error);
          }
          dt->currentShiftIdx = updShiftIdx;
          return NO_ERROR;
      }
    
  }
  return SKIP;
}

bool updateTimezoneForShifts_m(SHDatetime *dt,SHError *error){
  int resultCode = _updateTimezoneForShifts(dt,error);
  return resultCode == NO_ERROR || resultCode == SKIP;
}

