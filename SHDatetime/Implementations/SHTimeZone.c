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
#include <SHErrorHandling.h>
#include <assert.h>
#include <string.h>

static bool _compareDtAndTimeShift(SHDatetime const *dt,SHTimeshift *shift,bool (*compare)(double,double)){
		double timestamp = 0;
		double timezoneShiftTimestamp = 0;
		SHDatetime copy;
		SHDatetime timezoneShiftAsDt;
		memcpy(&copy, dt, sizeof(SHDatetime));
		SH_dtSetTimezoneOffset(&copy, 0);
		
		SH_dtToTimestamp(&copy, &timestamp);
		
		memset(&timezoneShiftAsDt, 0 , sizeof(SHDatetime));
		timezoneShiftAsDt.year = SH_BASE_YEAR;
		timezoneShiftAsDt.month = shift->month;
		timezoneShiftAsDt.day = shift->day;
		timezoneShiftAsDt.hour = shift->hour;
		timezoneShiftAsDt.minute = shift->minute;
		
		SH_dtToTimestamp(&timezoneShiftAsDt, &timezoneShiftTimestamp);

		return compare(timestamp, timezoneShiftTimestamp);
}

static bool _isDtAfterShift(double timestamp, double shift){
	return timestamp >= shift;
}

static bool _isDtBeforeShift(double timestamp, double shift){
	return timestamp < shift;
}


int32_t SH_selectTimeShiftIdxForDt(SHDatetime *dt,SHTimeshift *shifts, int32_t shiftCount){
	assert(dt);
	assert(shifts);
	int32_t max = shiftCount;
	for(int32_t i = 0;i<max;i++){
		SHTimeshift *shift = &shifts[i];
		int32_t wrappedIdx = (i + 1) % max;
		SHTimeshift *next = &shifts[wrappedIdx];
		if(_compareDtAndTimeShift(dt, shift, &_isDtBeforeShift)){
			return ((i - 1) + max) % max;
		}
		if(_compareDtAndTimeShift(dt, shift, &_isDtAfterShift) && _compareDtAndTimeShift(dt, next, &_isDtBeforeShift)){
			return i;
		}
		if(_compareDtAndTimeShift(dt, next, &_isDtAfterShift)){
			return wrappedIdx;
		}
	}
	return SH_NOT_FOUND;
}

int32_t SH_findTimeShiftIdx(SHDatetime *dt){
	assert(dt);
	if(dt->shifts){
		return SH_selectTimeShiftIdxForDt(dt,dt->shifts,dt->shiftLen);
	}
	return SH_NOT_FOUND;
}

SHErrorCode SH_UpdateTimezoneForShifts(SHDatetime *dt){
	shLog("SH_UpdateTimezoneForShifts");
	SHErrorCode status = SH_NO_ERROR;
	if(!dt->shifts) goto nochange;
	int32_t oldShiftIdx = dt->currentShiftIdx;
	if(oldShiftIdx < 0 || oldShiftIdx >= dt->shiftLen){
		SH_notifyOfError(SH_OUT_OF_RANGE, "timezone current index is out of range");
		status = SH_OUT_OF_RANGE;
		goto cleanup;
	}
	double timestamp;
	if((status = SH_dtToTimestamp(dt, &timestamp)) != SH_NO_ERROR ){
		goto cleanup;
	}
	int32_t updShiftIdx = SH_findTimeShiftIdx(dt);
	SHTimeshift *oldShift = &dt->shifts[oldShiftIdx];
	SHTimeshift *updShift = &dt->shifts[updShiftIdx];
	if(oldShift != updShift){
		dt->timezoneOffset -= oldShift->adjustment;
		dt->timezoneOffset += updShift->adjustment;
		
		int32_t shiftCuspTS = updShift->hour * SH_HOUR_IN_SECONDS + updShift->minute * SH_MIN_IN_SECONDS;
		double dtTS = 0;
		if((status = SH_dtToTimeOfDay(dt, &dtTS)) != SH_NO_ERROR) {
			goto cleanup;
		}
		double shiftDif = (dtTS-shiftCuspTS);
		if(shiftDif >= SH_HOUR_IN_SECONDS || dt->day > updShift->day||dt->month > updShift->month){
			timestamp += oldShift->adjustment;
			timestamp -= updShift->adjustment;
		}
		SHTimeshift *shifts = dt->shifts;
		int32_t shiftLen = dt->shiftLen;
		if((status = SH_timestampToDt(timestamp, dt->timezoneOffset, dt)) != SH_NO_ERROR) {
			SH_notifyOfError(status,"error while applying timeshift change");
			goto cleanup;
		}
		dt->shifts = shifts;
		dt->shiftLen = shiftLen;
		dt->currentShiftIdx = updShiftIdx;
		goto success;
	}
	success:
	nochange:
	cleanup:
		return status;
}

