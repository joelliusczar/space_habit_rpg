//
//	SHTimeZone.c
//	SHCommon
//
//	Created by Joel Pridgen on 4/14/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHTimeZone.h"
#include "SHDatetimeFuncs.h"
#include "SHUtilConstants.h"
#include "SHErrorHandling.h"

static bool _compareDtAndTimeShift(SHDatetime *dt,SHTimeshift *shift,bool (*compare)(int64_t,int64_t)){
		SHError error;
		int64_t dtTimestamp = shCreateDateTime(SH_BASE_YEAR,dt->month,dt->day,dt->hour,dt->minute
													,dt->second,0,&error);
		int64_t shiftTimestamp = shCreateDateTime(SH_BASE_YEAR,shift->month,shift->day,shift->hour
														,shift->minute,0,0,&error);
		return compare(dtTimestamp,shiftTimestamp);
}

static bool _isDtAfterShift(int64_t dt,int64_t shift){
	return dt >= shift;
}

static bool _isAfterShiftCusp(SHDatetime *dt,SHTimeshift *extant){
	return _compareDtAndTimeShift(dt,extant,&_isDtAfterShift);
}

static bool _isDtBeforeShift(int64_t dt,int64_t shift){
	return dt < shift;
}

static bool _isBeforeShiftCusp(SHDatetime *dt,SHTimeshift *next){
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
		return shHandleError(SH_NULL_VALUES, "Null inputs", error);
	}
	if(dt->shifts){
		int oldShiftIdx = dt->currentShiftIdx;
		if(oldShiftIdx < 0 || oldShiftIdx >= dt->shiftLen){
			return SH_INVALID_STATE;
		}
		double ts;
		SHError cnvtErr;
		shPrepareSHError(&cnvtErr);
		if(!shTryDtToTimestamp(dt,&ts,&cnvtErr)){
			return shHandleError(cnvtErr.code,"Error in date object to"
				"timestamp in tz update",error);
		}
		int updShiftIdx = shFindTimeShiftIdx(dt);
		SHTimeshift *oldShift = &dt->shifts[oldShiftIdx];
		SHTimeshift *updShift = &dt->shifts[updShiftIdx];
		if(oldShift != updShift){
			dt->timezoneOffset -= oldShift->adjustment;
			dt->timezoneOffset += updShift->adjustment;
			int shiftCuspTS = shCreateTime(updShift->hour,updShift->minute,0,&cnvtErr);
			if(cnvtErr.code){
				return shHandleError(cnvtErr.code,"Error creating time",error);
			}
			int dtTS = shExtractTime(dt,&cnvtErr);
			if(cnvtErr.code){
				return shHandleError(cnvtErr.code,"Error extracting time",error);
			}
			int shiftDif = (dtTS-shiftCuspTS);
			if(shiftDif >= SH_HOUR_IN_SECONDS||dt->day > updShift->day||dt->month > updShift->month){
				ts += oldShift->adjustment;
				ts -= updShift->adjustment;
			}
			if(!shTimestampToDtUnitsOnly(ts,dt,&cnvtErr)){
				return shHandleError(cnvtErr.code,"Error timestampt to date"
					" time object.",error);
			}
			dt->currentShiftIdx = updShiftIdx;
			return SH_NO_ERROR;
		}
		
	}
	return SKIP;
}

bool shUpdateTimezoneForShifts(SHDatetime *dt,SHError *error){
	int resultCode = _updateTimezoneForShifts(dt,error);
	return resultCode == SH_NO_ERROR || resultCode == SKIP;
}

