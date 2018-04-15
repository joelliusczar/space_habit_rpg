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

int _compareDtAndTimeShift(SHDateTime *dt,TimeShift *shift,int (*compare)(long,long)){
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

int _isAfterShiftCusp(SHDateTime *dt,TimeShift *extant){
    return _compareDtAndTimeShift(dt,extant,&_isDtAfterShift);
}

int _isDtBeforeShift(long dt,long shift){
    return dt < shift;
}

int _isBeforeShiftCusp(SHDateTime *dt,TimeShift *next){
    return _compareDtAndTimeShift(dt,next,&_isDtBeforeShift);
}

int selectTimeShiftForDt(SHDateTime *dt,TimeShift *shifts,int shiftCount){
    int max = shiftCount;
    for(int i = 0;i<max;i++){
        TimeShift extant = shifts[i];
        int wrappedIdx = (i+1) % max;
        TimeShift next = shifts[wrappedIdx];
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

int findTimeShiftIdx(SHDateTime *dt){
    if(dt->shifts){
        return selectTimeShiftForDt(dt,dt->shifts,dt->shiftLen);
    }
    return NOT_FOUND;
}

int updateTimezoneForShifts(SHDateTime *dt){
    if(dt->shifts){
        
        int oldShiftIdx = dt->currentShiftIdx;
        if(oldShiftIdx < 0 || oldShiftIdx >= dt->shiftLen){
            return INVALID_STATE;
        }
        long ts;
        if(tryDtToTimestamp(dt,&ts)) return INVALID_STATE;
        int updShiftIdx = findTimeShiftIdx(dt);
        TimeShift *oldShift = &dt->shifts[oldShiftIdx];
        TimeShift *updShift = &dt->shifts[updShiftIdx];
        if(oldShift != updShift){
            dt->timezoneOffset -= oldShift->adjustment;
            dt->timezoneOffset += updShift->adjustment;
            int error;
            int shiftCuspTS = createTime(updShift->hour,updShift->minute,0,&error);
            int dtTS = extractTime(dt,&error);
            int shiftDif = (dtTS-shiftCuspTS);
            if(shiftDif >= UNIX_HOUR||dt->day > updShift->day||dt->month > updShift->month){
                ts += oldShift->adjustment;
                ts -= updShift->adjustment;
            }
            if(timestampToDtUnitsOnly(ts,dt)) return GEN_ERROR;
            dt->currentShiftIdx = updShiftIdx;
            return NO_ERROR;
        }
        
    }
    return SKIP;
}

