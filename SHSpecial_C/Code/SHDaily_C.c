//
//	SHDaily_c.c
//	SHModels
//
//	Created by Joel Pridgen on 4/17/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDaily_C.h"
#include "SHDTConstants.h"
#include "SHArray.h"
#include "SHErrorHandling.h"
#include <stdlib.h>


//these define our find algorithms for specific types
SH_DEF_FIND_IDX_REV(bool,int,,)
SH_DEF_FIND_IDX(bool,int,,)

bool _ArePreviousDateInputsValid(SHDatetime *lastDueDate,SHDatetime *checkinDate
	,SHRateValueItem *rvi,int64_t scaler,SHDatetime *ans,SHError *error);


static bool _isDayActive(bool isActive,int64_t idx,int blank){
	(void)idx;(void)blank;
	return isActive;
}


static void _setDayCounts(int64_t *daysCounts,bool *activeDays,int64_t counter
	,bool isReverse)
{
	for(int dayIdx = 0;dayIdx < SH_WEEKLEN;dayIdx++){
		int useIdx = isReverse? SH_WEEKLEN - dayIdx -1 : dayIdx;
		counter++;
		daysCounts[useIdx] = counter;
		if(activeDays[useIdx]){
			counter = 0;
		}
	}
}


void shFillWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays
	,SHRateValueItem *rvi)
{
	if(!(daysAheadCounts&&daysBeforeCounts&&activeDays&&rvi)) return;
	for(int dayIdx = 0;dayIdx < SH_WEEKLEN;dayIdx++){
		rvi[dayIdx].forrange = daysAheadCounts[dayIdx];
		rvi[dayIdx].backrange = daysBeforeCounts[dayIdx];
		rvi[dayIdx].isDayActive = activeDays[dayIdx];
	}
}


static int64_t _distanceFromActiveWeek(int64_t weekNum,int64_t weekScaler){
	return weekNum % (weekScaler * SH_DAYS_IN_WEEK);
}


void shBuildWeek(bool *activeDays,int64_t scaler,SHRateValueItem *rvi){
	if(!(activeDays&&rvi)) return;
	int64_t lastIdx = shFindIdxRev(bool,int)(activeDays,SH_WEEKLEN,&_isDayActive,0);
	if(lastIdx == NOT_FOUND){
		shBuildEmptyWeek(rvi);
		return;
	}
	int64_t daysBefore = (SH_WEEKLEN - lastIdx) + (scaler -1)*SH_WEEKLEN -1;
	int64_t daysBeforeCounts[SH_WEEKLEN];
	_setDayCounts(daysBeforeCounts,activeDays,daysBefore,false);
	int64_t firstIdx = shFindIdx(bool,int)(activeDays,SH_WEEKLEN,&_isDayActive,0);
	int64_t daysAhead = firstIdx + (scaler -1)*SH_WEEKLEN;
	int64_t daysAheadCounts[SH_WEEKLEN];
	_setDayCounts(daysAheadCounts,activeDays,daysAhead,true);
	
	return shFillWeek(daysAheadCounts,daysBeforeCounts,activeDays,rvi);
}


void shBuildEmptyWeek(SHRateValueItem *rvi){
	for(int i = 0;i < SH_WEEKLEN;i++){
		rvi[i].forrange = 0;
		rvi[i].backrange = 0;
		rvi[i].isDayActive = false;
	}
}

static int _findPrevDayIdxInWeek(bool isActiveWeek,int checkinDayIdx
	,SHRateValueItem *week)
{
	int prevDayIdx = SH_DAYS_IN_WEEK;
	for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
		int reverseDayIdx = isActiveWeek ?
			(SH_DAYS_IN_WEEK + checkinDayIdx - i -1) % SH_DAYS_IN_WEEK :
			SH_DAYS_IN_WEEK - i - 1;
		if(week[reverseDayIdx].isDayActive){
			prevDayIdx = reverseDayIdx;
			break;
		}
	}
	return prevDayIdx < SH_DAYS_IN_WEEK ? prevDayIdx : NOT_FOUND;
}

static int _findNextDayIdx(int checkinDayIdx,SHRateValueItem* week){
	for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
		int dayIdx = (SH_DAYS_IN_WEEK + checkinDayIdx + i) % SH_DAYS_IN_WEEK;
		if(week[dayIdx].isDayActive){
			return dayIdx;
		}
	}
	return NOT_FOUND;
}

static int _offsetForSameWeek(bool isActiveWeek, int inputDayIdx,int prevDayIdx){
	/*
	 if checkin day is in active week but before all active days
	 push it back a week so that it get's the last active day of
	 the previous active weeks
	 */
	return prevDayIdx > inputDayIdx || (prevDayIdx == inputDayIdx && isActiveWeek)
		? SH_DAYS_IN_WEEK : 0;
}


static void _prepareDatetimeForCalculations(SHDatetime *dt, int64_t dayStartTime, SHError *error) {
	memset(error, 0, sizeof(SHError));
	int32_t timeOfDayInSeconds = (int32_t)shExtractTime(dt, error);
	if(timeOfDayInSeconds >= dayStartTime) {
		shDayStartInPlace(dt);
		return;
	}
	shDayStartInPlace(dt);
	dt->timezoneOffset = 0; 
	
	//didn't want to free dt->shifts in case it's used on another pointer, but also
	//did not want to null it out and possibly loose a reference to it, creating a memory leak
	dt->shiftLen = 0;
	shTryAddDaysToDtInPlace(dt, -1, 0, error);
}


bool shPreviousDueDateWithPreparedInputs_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
	,SHRateValueItem *rvi, int64_t scaler, int64_t dayStartHour, SHDatetime *ans, SHError *error)
{
	SHDatetime lastDueDatePrepared = *lastDueDate;
	SHDatetime checkinDatePrepared = *checkinDate;
	_prepareDatetimeForCalculations(&lastDueDatePrepared, dayStartHour, error);
	_prepareDatetimeForCalculations(&checkinDatePrepared, dayStartHour, error);
	return shPreviousDueDate_WEEKLY(&lastDueDatePrepared, &checkinDatePrepared,
		rvi, scaler, dayStartHour, ans, error);
}

bool shPreviousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
	,SHRateValueItem *rvi,int64_t scaler,int64_t dayStartHour,SHDatetime *ans,SHError *error)
{
	(void)dayStartHour; //decided to move this up the call chain
	shLog("previousDueDate_WEEKLY");
	if(!_ArePreviousDateInputsValid(lastDueDate,checkinDate,rvi,scaler,ans,error)){
		return false;
	}
	int lastDayIdx = shCalcWeekdayIdx(lastDueDate,error);
	SHDatetime firstDayOfFirstWeek;
	shTryAddDaysToDt(lastDueDate,-lastDayIdx,0,&firstDayOfFirstWeek,error);
	int64_t daySpan = shDateDiffDays(checkinDate,&firstDayOfFirstWeek,error);
	int checkinDayIdx = shCalcWeekdayIdx(checkinDate,error);
	int64_t firstSunToPrevSunSpan = daySpan - checkinDayIdx;
	bool isActiveWeek = _distanceFromActiveWeek(firstSunToPrevSunSpan, scaler) == 0;
	int prevDayIdx = _findPrevDayIdxInWeek(isActiveWeek, checkinDayIdx, rvi);
	firstSunToPrevSunSpan -= (_offsetForSameWeek(isActiveWeek,checkinDayIdx,prevDayIdx));
	int64_t sunOfPrevActionWeek = firstSunToPrevSunSpan - _distanceFromActiveWeek(firstSunToPrevSunSpan, scaler);
	shTryAddDaysToDt(&firstDayOfFirstWeek,sunOfPrevActionWeek + prevDayIdx,0,ans,error);
	if((shDtToTimestamp(ans,error) > shDtToTimestamp(checkinDate,error))){
			return shHandleError(SH_OUT_OF_RANGE
				,"The calculated answer for previous due date is after the checkindate",error);
	}
	shLog("leaving previousDueDate_WEEKLY");
	return true;
}


SHDatetime* shBothWeeklyDueDatesFromLastDueDate(SHDatetime* lastDueDate,SHDatetime* checkinDate,
	SHRateValueItem* week,int64_t scaler, int64_t dayStartHour,SHError *error)
{
	shLog("bothWeeklyDueDatesFromLastDueDate");
	SHDatetime previousDate;
	SHDatetime lastDueDatePrepared = *lastDueDate;
	SHDatetime checkinDatePrepared = *checkinDate;
	_prepareDatetimeForCalculations(&lastDueDatePrepared, dayStartHour, error);
	_prepareDatetimeForCalculations(&checkinDatePrepared, dayStartHour, error);
	shPreviousDueDate_WEEKLY(&lastDueDatePrepared, &checkinDatePrepared, week, scaler,
		dayStartHour, &previousDate, error);
	if(error && error->code != SH_NO_ERROR){
		return shHandleErrorRetNull(error->code,"Error getting previous date",error);
	}
	int prevDayIdx = shCalcWeekdayIdx(&previousDate, error);
	SHDatetime firstDayOfPrevWeek;
	shTryAddDaysToDt(&previousDate, -1 * prevDayIdx, 0, &firstDayOfPrevWeek, error);
	int64_t daySpan = shDateDiffDays(checkinDate,&firstDayOfPrevWeek, error);
	int checkinDayIdx = shCalcWeekdayIdx(checkinDate, error);
	int64_t prevSunToThisSunSpan = daySpan - checkinDayIdx;
	int64_t weekCount = (_distanceFromActiveWeek(prevSunToThisSunSpan, scaler)/SH_DAYS_IN_WEEK);
	int64_t nextActiveWeek = prevSunToThisSunSpan + (((scaler - weekCount) % scaler) * SH_DAYS_IN_WEEK);
	int weekStartIdx = weekCount == 0 ? checkinDayIdx : 0;
	int nextDayIdx = _findNextDayIdx(weekStartIdx, week);
	int64_t sameWeekOffset = nextDayIdx < checkinDayIdx && weekCount == 0 ? scaler * SH_DAYS_IN_WEEK : 0;
	SHDatetime result;
	shTryAddDaysToDt(&firstDayOfPrevWeek, nextActiveWeek + nextDayIdx + sameWeekOffset,0,&result, error);
	SHDatetime* resultPair = malloc(sizeof(SHDatetime)*2);
	resultPair[0] = previousDate;
	resultPair[1] = result;
	shLog("leaving bothWeeklyDueDatesFromLastDueDate");
	return resultPair;
}

bool shNextDueDate_WEEKLY(SHDatetime* lastDueDate,SHDatetime* checkinDate
	,SHRateValueItem* week, int64_t scaler, int64_t dayStartHour, SHDatetime *ans, SHError* error)
{
	shLog("nextDueDate_WEEKLY\n");
	if(!ans){
		return shHandleError(SH_NULL_VALUES, "One of the inputs is null", error);
	}
	SHDatetime* resultPair = shBothWeeklyDueDatesFromLastDueDate(lastDueDate, checkinDate, week, scaler,
		dayStartHour, error);
	if(!resultPair){
		return shHandleError(SH_GEN_ERROR, "Error calculating next due date", error);
	}
	memcpy(ans,&resultPair[1],sizeof(SHDatetime));
	shFreeSHDatetime(resultPair,2);
	if(error && error->code != SH_NO_ERROR){
		return shHandleError(error->code, "Error calculating next due date", error);
	}
	shLog("leaving nextDueDate_WEEKLY\n");
	SHDatetime checkinDateStart;
	memcpy(&checkinDateStart,checkinDate,sizeof(SHDatetime));
	shDayStartInPlace(&checkinDateStart);
	if(shDtToTimestamp(ans,error) < shDtToTimestamp(&checkinDateStart,error)){
		char ansStr[50];
		char checkinStr[50];
		shDTToString(ans,ansStr);
		shDTToString(checkinDate,checkinStr);
		char frmtErrMsg[200];
		sprintf(frmtErrMsg, "The calculated next due date was before the check in date. Answer: %s "
			"checkinDate: %s Scaler:%"PRId64,ansStr,checkinStr,scaler);
		return shHandleError(SH_OUT_OF_RANGE, frmtErrMsg, error);
	}
	return true;
}


bool shNextDueDate_WEEKLY_INV(SHDatetime* lastDueDate,SHDatetime* checkinDate, SHRateValueItem* week,
	int64_t scaler, int64_t dayStartHour, SHDatetime *ans, SHError* error)
{
	(void)lastDueDate;
	(void)checkinDate;
	(void)week;
	(void)scaler;
	(void)ans;
	(void)error;
	(void)dayStartHour;
	#warning TODO: fill out this function
	return true;
}

bool _ArePreviousDateInputsValid(SHDatetime *lastDueDate,SHDatetime *checkinDate
,SHRateValueItem *rvi,int64_t scaler,SHDatetime *ans,SHError *error){
	if(!(ans&&lastDueDate&&checkinDate&&rvi&&ans)){
		return shHandleError(SH_NULL_VALUES, "One of the inputs is null", error);
	}
	if(scaler < 1){
		return shHandleError(SH_OUT_OF_RANGE, "Scaler needs to be greater than zero", error);
	}
	SHError *cnvtErr = calloc(2, sizeof(SHError));
	if(!(shDtToTimestamp(checkinDate,&cnvtErr[0]) >= shDtToTimestamp(lastDueDate,&cnvtErr[1]))){
			return shHandleError(SH_OUT_OF_RANGE,"Checkindate needs to be after lastDueDate",error);
	}
	if(cnvtErr[0].code||cnvtErr[0].code){
	 return shHandleError(cnvtErr[0].code||cnvtErr[0].code,
		"There was a conversion error with the datetimes", error);
	}
	int64_t lastDayIdx = shCalcWeekdayIdx(lastDueDate,error);
	if(!rvi[lastDayIdx].isDayActive){
		return shHandleError(SH_INVALID_STATE, "Previous due date is on an non active day.", error);
	}
	return true;
}