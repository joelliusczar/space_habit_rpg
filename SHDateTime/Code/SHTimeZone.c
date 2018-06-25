//
//  SHTimeZone.c
//  SHCommon
//
//  Created by Joel Pridgen on 4/14/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHTimeZone.h"
#include "SHDatetime.h"
#include "SHConstants.h"
#include "ErrorHandling.h"

int _compareDtAndTimeShift(SHDatetime *dt,Timeshift *shift,int (*compare)(long,long)){
    int error;
    long dtTimestamp = createDateTime(BASE_YEAR,dt->month,dt->day,dt->hour,dt->minute
                                      ,dt->second,0,&error);
    long shiftTimestamp = createDateTime(BASE_YEAR,shift->month,shift->day,shift->hour
                                         ,shift->minute,0,0,&error);
    return compare(dtTimestamp,shiftTimestamp);
}

int _isDtAfterShift(long dt,long shift){
    return dt >= shift;
}

int _isAfterShiftCusp(SHDatetime *dt,Timeshift *extant){
    return _compareDtAndTimeShift(dt,extant,&_isDtAfterShift);
}

int _isDtBeforeShift(long dt,long shift){
    return dt < shift;
}

int _isBeforeShiftCusp(SHDatetime *dt,Timeshift *next){
    return _compareDtAndTimeShift(dt,next,&_isDtBeforeShift);
}

int selectTimeShiftForDt(SHDatetime *dt,Timeshift *shifts,int shiftCount){
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
    if(dt->shifts){
        return selectTimeShiftForDt(dt,dt->shifts,dt->shiftLen);
    }
    return NOT_FOUND;
}

bool updateTimezoneForShifts(SHDatetime *dt,int *error){
    if(dt->shifts){
        
        int oldShiftIdx = dt->currentShiftIdx;
        if(oldShiftIdx < 0 || oldShiftIdx >= dt->shiftLen){
            return INVALID_STATE;
        }
        double ts;
        int cnvtErr;
        if(!tryDtToTimestamp(dt,&ts,&cnvtErr)) return setErrorCode(cnvtErr,error);
        int updShiftIdx = findTimeShiftIdx(dt);
        Timeshift *oldShift = &dt->shifts[oldShiftIdx];
        Timeshift *updShift = &dt->shifts[updShiftIdx];
        if(oldShift != updShift){
            dt->timezoneOffset -= oldShift->adjustment;
            dt->timezoneOffset += updShift->adjustment;
            int shiftCuspTS = createTime(updShift->hour,updShift->minute,0,&cnvtErr);
            if(cnvtErr) return setErrorCode(cnvtErr,error);
            int dtTS = extractTime(dt,&cnvtErr);
            if(cnvtErr) return setErrorCode(cnvtErr,error);
            int shiftDif = (dtTS-shiftCuspTS);
            if(shiftDif >= HOUR_IN_SECONDS||dt->day > updShift->day||dt->month > updShift->month){
                ts += oldShift->adjustment;
                ts -= updShift->adjustment;
            }
            if(!timestampToDtUnitsOnly(ts,dt,&cnvtErr)) return setErrorCode(cnvtErr,error);
            dt->currentShiftIdx = updShiftIdx;
            return NO_ERROR;
        }
        
    }
    return SKIP;
}

