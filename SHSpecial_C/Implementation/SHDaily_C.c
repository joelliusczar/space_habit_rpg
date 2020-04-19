////
////	SHDaily_c.c
////	SHModels
////
////	Created by Joel Pridgen on 4/17/18.
////	Copyright © 2018 Joel Gillette. All rights reserved.
////
//
#include "SHDaily_C.h"
//#include "SHDTConstants.h"
//#include "SHArray.h"
//#include "SHErrorHandling.h"
//#include <stdlib.h>
//#include <float.h>
//
//
////these define our find algorithms for specific types
//SH_DEF_FIND_IDX_REV(bool,int32_t,,)
//SH_DEF_FIND_IDX(bool,int32_t,,)
//
//bool _ArePreviousDateInputsValid(SHDatetime *lastDueDate,SHDatetime *checkinDate
//	,SHRateValueItem *rvi,int64_t scaler,SHDatetime *ans,SHError *error);
//
//
//static bool _isDayActive(bool isActive,int64_t idx, int32_t blank){
//	(void)idx;(void)blank;
//	return isActive;
//}
//
//
//static void _setDayCounts(int64_t *daysCounts,bool *activeDays,int64_t counter
//	,bool isReverse)
//{
//	for(int32_t dayIdx = 0;dayIdx < SH_WEEKLEN;dayIdx++){
//		int32_t useIdx = isReverse? SH_WEEKLEN - dayIdx -1 : dayIdx;
//		counter++;
//		daysCounts[useIdx] = counter;
//		if(activeDays[useIdx]){
//			counter = 0;
//		}
//	}
//}
//
//
//void sh_fillWeek(int64_t *daysAheadCounts, int64_t *daysBeforeCounts, bool *activeDays
//	,SHRateValueItem *rvi)
//{
//	if(!(daysAheadCounts && daysBeforeCounts && activeDays&&rvi)) return;
//	for(int32_t dayIdx = 0;dayIdx < SH_WEEKLEN;dayIdx++){
//		rvi[dayIdx].forrange = daysAheadCounts[dayIdx];
//		rvi[dayIdx].backrange = daysBeforeCounts[dayIdx];
//		rvi[dayIdx].isDayActive = activeDays[dayIdx];
//	}
//}
//
//
//static int64_t _distanceFromActiveWeek(int64_t weekNum,int64_t weekScaler){
//	return weekNum % (weekScaler * SH_DAYS_IN_WEEK);
//}
//
//
//void sh_buildWeek(bool *activeDays,int64_t scaler,SHRateValueItem *rvi){
//	if(!(activeDays&&rvi)) return;
//	int64_t lastIdx = shFindIdxRev(bool,int32_t)(activeDays,SH_WEEKLEN,&_isDayActive,0);
//	if(lastIdx == SH_NOT_FOUND){
//		sh_buildEmptyWeek(rvi);
//		return;
//	}
//	int64_t daysBefore = (SH_WEEKLEN - lastIdx) + (scaler -1)*SH_WEEKLEN -1;
//	int64_t daysBeforeCounts[SH_WEEKLEN];
//	_setDayCounts(daysBeforeCounts,activeDays,daysBefore,false);
//	int64_t firstIdx = shFindIdx(bool,int32_t)(activeDays,SH_WEEKLEN,&_isDayActive,0);
//	int64_t daysAhead = firstIdx + (scaler -1)*SH_WEEKLEN;
//	int64_t daysAheadCounts[SH_WEEKLEN];
//	_setDayCounts(daysAheadCounts,activeDays,daysAhead,true);
//
//	return sh_fillWeek(daysAheadCounts,daysBeforeCounts,activeDays,rvi);
//}
//
//
//void sh_buildEmptyWeek(SHRateValueItem *rvi){
//	for(int i = 0;i < SH_WEEKLEN;i++){
//		rvi[i].forrange = 0;
//		rvi[i].backrange = 0;
//		rvi[i].isDayActive = false;
//	}
//}
//
//
//static int32_t _findPrevDayIdxInWeek(bool isActiveWeek, int32_t checkinDayIdx,
//	SHRateValueItem *week)
//{
//	int32_t prevDayIdx = SH_DAYS_IN_WEEK;
//	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++){
//		int32_t reverseDayIdx = isActiveWeek ?
//			(SH_DAYS_IN_WEEK + checkinDayIdx - i -1) % SH_DAYS_IN_WEEK :
//			SH_DAYS_IN_WEEK - i - 1;
//		if(week[reverseDayIdx].isDayActive){
//			prevDayIdx = reverseDayIdx;
//			break;
//		}
//	}
//	return prevDayIdx < SH_DAYS_IN_WEEK ? prevDayIdx : SH_NOT_FOUND;
//}
//
//
//static int32_t _findNextDayIdx(int32_t checkinDayIdx,SHRateValueItem* week){
//	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++){
//		int32_t dayIdx = (SH_DAYS_IN_WEEK + checkinDayIdx + i) % SH_DAYS_IN_WEEK;
//		if(week[dayIdx].isDayActive){
//			return dayIdx;
//		}
//	}
//	return SH_NOT_FOUND;
//}
//
//static int32_t _offsetForSameWeek(bool isActiveWeek, int32_t inputDayIdx,int32_t prevDayIdx){
//	/*
//	 if checkin day is in active week but before all active days
//	 push it back a week so that it get's the last active day of
//	 the previous active weeks
//	 */
//	return prevDayIdx > inputDayIdx || (prevDayIdx == inputDayIdx && isActiveWeek)
//		? SH_DAYS_IN_WEEK : 0;
//}
//
//
//static SHErrorCode _prepareDatetimeForCalculations(SHDatetime *dt, int64_t dayStartTime) {
//	SHErrorCode status = SH_NO_ERROR;
//	double timeOfDay = 0;
//	if((status = SH_dtToTimeOfDay(dt, &timeOfDay)) != SH_NO_ERROR) {
//		goto fnExit;
//	}
//	int32_t timeOfDayInSeconds = (int32_t)timeOfDay;
//	if(timeOfDayInSeconds >= dayStartTime) {
//		SH_setToDayStart(dt);
//		goto fnExit;
//	}
//	SH_setToDayStart(dt);
//	dt->timezoneOffset = 0;
//
//	//didn't want to free dt->shifts in case it's used on another pointer, but also
//	//did not want to null it out and possibly loose a reference to it, creating a memory leak
//	dt->shiftLen = 0;
//	SH_addDaysToDt(dt, -1, SH_TIME_ADJUST_NO_OPTION);
//	fnExit:
//		return status;
//}
//
//
//static SHErrorCode _previousDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans)
//{
//	shLog("previousDueDate_WEEKLY");
//	SHErrorCode status = SH_NO_ERROR;
//	double checkinDateTimestamp = 0;
//	double lastCheckinTimestamp = 1;
//	SH_dtToTimestamp(input->checkinDate,&checkinDateTimestamp);
//	SH_dtToTimestamp(input->lastDueDate,&lastCheckinTimestamp);
//	if(lastCheckinTimestamp >= checkinDateTimestamp) {
//		status = SH_ILLEGAL_INPUTS;
//		SH_notifyOfError(SH_INVALID_STATE, "Checkindate needs to be after lastDueDate");
//		goto fnExit;
//	}
//
//	int32_t lastDayIdx = SH_NOT_FOUND;
//	if((lastDayIdx = SH_weekdayIdx(input->lastDueDate, input->weekStartOffset)) == SH_NOT_FOUND) {
//		status = SH_INPUT_BAD_RESULTS;
//		goto fnExit;
//	}
//	if(!input->rvi[lastDayIdx].isDayActive){
//		SH_notifyOfError(SH_INVALID_STATE, "Previous due date is on an non active day.");
//		status = SH_INVALID_STATE;
//		goto fnExit;
//	}
//	SHDatetime firstDayOfFirstWeek = *input->lastDueDate;
//	SH_addDaysToDt(&firstDayOfFirstWeek, -lastDayIdx, SH_TIME_ADJUST_NO_OPTION);
//	int64_t daySpan = 0;
//	if((status = SH_dateDiffDays(input->checkinDate, &firstDayOfFirstWeek, &daySpan)) != SH_NO_ERROR) {
//		goto fnExit;
//	}
//	int32_t checkinDayIdx = SH_weekdayIdx(input->checkinDate, input->weekStartOffset);
//	int64_t firstSunToPrevSunSpan = daySpan - checkinDayIdx;
//	bool isActiveWeek = _distanceFromActiveWeek(firstSunToPrevSunSpan, input->intervalSize) == 0;
//	int32_t prevDayIdx = _findPrevDayIdxInWeek(isActiveWeek, checkinDayIdx, input->rvi);
//	firstSunToPrevSunSpan -= (_offsetForSameWeek(isActiveWeek, checkinDayIdx, prevDayIdx));
//	int64_t sunOfPrevActionWeek = firstSunToPrevSunSpan - _distanceFromActiveWeek(firstSunToPrevSunSpan,
//		input->intervalSize);
//	*ans = firstDayOfFirstWeek;
//	if((status = SH_addDaysToDt(ans, sunOfPrevActionWeek + prevDayIdx, SH_TIME_ADJUST_NO_OPTION)) != SH_NO_ERROR) {
//		goto fnExit;
//	}
//#ifdef SH_POST_DUE_DATE_CALC_CHECK
//	double ansTimestamp = DBL_MAX;
//	SH_dtToTimestamp(ans, &ansTimestamp);
//	if(ansTimestamp > checkinDateTimestamp) {
//		status = SH_INPUT_BAD_RESULTS;
//		SH_notifyOfError(status, "The calculated answer for previous due date is after the checkindate");
//		goto fnExit;
//	}
//#endif
//
//	shLog("leaving previousDueDate_WEEKLY");
//	fnExit:
//		return status;
//}
//
//
//static SHErrorCode _bothWeeklyDueDatesFromLastDueDate(SHDailyWeeklyDueDateInput *input, SHDatetime **ans, int32_t *ansLen)
//{
//	shLog("bothWeeklyDueDatesFromLastDueDate");
//	SHErrorCode status = SH_NO_ERROR;
//	SHDatetime previousDate;
//
//	if((status = _previousDueDate_WEEKLY(input, &previousDate)) != SH_NO_ERROR) {
//		goto fnExit;
//	}
//
//	int32_t prevDayIdx = SH_weekdayIdx(&previousDate, input->weekStartOffset);
//	SHDatetime firstDayOfPrevWeek = previousDate;
//	SH_addDaysToDt(&firstDayOfPrevWeek, -1 * prevDayIdx, SH_TIME_ADJUST_NO_OPTION);
//	int64_t daySpan = 0;
//	SH_dateDiffDays(input->checkinDate, &firstDayOfPrevWeek, &daySpan);
//	int32_t checkinDayIdx = SH_weekdayIdx(input->checkinDate, input->weekStartOffset);
//	int64_t prevSunToThisSunSpan = daySpan - checkinDayIdx;
//	int64_t weekCount = (_distanceFromActiveWeek(prevSunToThisSunSpan, input->intervalSize) / SH_DAYS_IN_WEEK);
//	int64_t nextActiveWeek = prevSunToThisSunSpan + (((input->intervalSize - weekCount) %
//		input->intervalSize) * SH_DAYS_IN_WEEK);
//	int32_t weekStartIdx = weekCount == 0 ? checkinDayIdx : 0;
//	int32_t nextDayIdx = _findNextDayIdx(weekStartIdx, input->rvi);
//	int64_t sameWeekOffset = nextDayIdx < checkinDayIdx && weekCount == 0 ? input->intervalSize * SH_DAYS_IN_WEEK : 0;
//	SHDatetime nextDueDate = firstDayOfPrevWeek;
//	SH_addDaysToDt(&nextDueDate, nextActiveWeek + nextDayIdx + sameWeekOffset, SH_TIME_ADJUST_NO_OPTION);
//
//	*ans = malloc(sizeof(SHDatetime) * 2);
//	if(!*ans) {
//		status = SH_ALLOC;
//		SH_notifyOfError(status, "Failed to allocate memory for due dates");
//		goto fnExit;
//	}
//	*ans[0] = previousDate;
//	*ans[1] = nextDueDate;
//	*ansLen = 2;
//	shLog("leaving bothWeeklyDueDatesFromLastDueDate");
//	fnExit:
//		return status;
//}
//
//
//static SHErrorCode _nextDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans)
//{
//	shLog("nextDueDate_WEEKLY\n");
//	SHErrorCode status = SH_NO_ERROR;
//	int32_t ansLen = 0;
//	SHDatetime *resultPair;
//	if((status = _bothWeeklyDueDatesFromLastDueDate(input, &resultPair, &ansLen)) != SH_NO_ERROR) {
//		goto fnExit;
//	}
//	if(!resultPair){
//		status = SH_GEN_ERROR;
//		SH_notifyOfError(status, "Error calculating next due date");
//		goto fnExit;
//	}
//	*ans = resultPair[1];
//
//	shLog("leaving nextDueDate_WEEKLY\n");
//
//#ifdef SH_POST_DUE_DATE_CALC_CHECK
//	SHDatetime checkinDateStart = input->checkinDate;
//	SH_dayStart(&checkinDateStart);
//	double ansTimestamp = DBL_MAX;
//	double checkinDateTimestamp = 0;
//	SH_dtToTimestamp(ans, &ansTimestamp);
//	SH_dtToTimestamp(&checkinDateStart, &checkinDateTimestamp);
//	if(ansTimestamp < checkinDateTimestamp) {
//		status = SH_INPUT_BAD_RESULTS;
//		char ansStr[75];
//		char checkinStr[75];
//		SH_DTToString(ans,ansStr);
//		SH_DTToString(input->checkinDate,checkinStr);
//		char frmtErrMsg[200];
//		sprintf(frmtErrMsg, "The calculated next due date was before the check in date. Answer: %s "
//			"checkinDate: %s Scaler:%"PRId64,ansStr,checkinStr,scaler);
//		SH_notifyOfError(status, frmtErrMsg);
//		goto cleanup;
//	}
//#endif
//	goto cleanup; //this is easier than wrapping the cleanup label in an ignore warning block
//	cleanup:
//		shFreeSHDatetime(resultPair,2);
//	fnExit:
//		return status;
//}
//
//
//SHErrorCode SH_previousDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans) {
//	SHErrorCode status = SH_NO_ERROR;
//	SHDatetime lastDueDatePrepared = *input->lastDueDate;
//	SHDatetime checkinDatePrepared = *input->checkinDate;
//	if((status = _prepareDatetimeForCalculations(&lastDueDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
//		 return status;
//	}
//	if((status = _prepareDatetimeForCalculations(&checkinDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
//		return status;
//	}
//	*input->lastDueDate = lastDueDatePrepared;
//	*input->checkinDate = checkinDatePrepared;
//	return _previousDueDate_WEEKLY(input, ans);
//}
//
//
//SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(SHDailyWeeklyDueDateInput *input, SHDatetime **ans, int32_t *ansLen){
//	SHErrorCode status = SH_NO_ERROR;
//	SHDatetime lastDueDatePrepared = *input->lastDueDate;
//	SHDatetime checkinDatePrepared = *input->checkinDate;
//	if((status = _prepareDatetimeForCalculations(&lastDueDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
//		return status;
//	}
//	if((status = _prepareDatetimeForCalculations(&checkinDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
//		return status;
//	}
//	*input->lastDueDate = lastDueDatePrepared;
//	*input->checkinDate = checkinDatePrepared;
//	return _bothWeeklyDueDatesFromLastDueDate(input, ans, ansLen);
//}
//
//
//SHErrorCode SH_nextDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans) {
//	SHErrorCode status = SH_NO_ERROR;
//	SHDatetime lastDueDatePrepared = *input->lastDueDate;
//	SHDatetime checkinDatePrepared = *input->checkinDate;
//	if((status = _prepareDatetimeForCalculations(&lastDueDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
//			return status;
//	}
//	if((status = _prepareDatetimeForCalculations(&checkinDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
//		return status;
//	}
//	*input->lastDueDate = lastDueDatePrepared;
//	*input->checkinDate = checkinDatePrepared;
//	return _nextDueDate_WEEKLY(input, ans);
//}
//
//
//int64_t sh_calcDaysAgoDayWasActive(int32_t weekdayIdx, int64_t intervalSize) {
//	if(intervalSize > 1){
//		int64_t result = ((SH_DAYS_IN_WEEK - weekdayIdx) + (intervalSize - 1) * SH_DAYS_IN_WEEK);
//		return result;
//	}
//	return SH_DAYS_IN_WEEK;
//}
//
//
//SHErrorCode SH_isDateADueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, bool *ans)
//{
//	SHErrorCode status = SH_NO_ERROR;
//	shLog("sh_isDateADueDate_WEEKLY\n");
//	SHDatetime nextDueDate;
//	memset(&nextDueDate, 0, sizeof(SHDatetime));
//	if((status = SH_nextDueDate_WEEKLY(input, &nextDueDate)) != SH_NO_ERROR) {
//		SH_notifyOfError(status, "Could not determine if date is a due date");
//		return status;
//	}
//	double nextDueDateTimestamp = 0;
//	SH_dtToTimestamp(&nextDueDate, &nextDueDateTimestamp);
//
//	SHDatetime checkinDatePrepared = *input->checkinDate;
//	_prepareDatetimeForCalculations(&checkinDatePrepared, input->dayStartHour);
//	double checkinDateTimestamp = -1; //any value that's different from nextDueDateTimestamp
//
//	SH_dtToTimestamp(&checkinDatePrepared, &checkinDateTimestamp);
//
//	*ans = nextDueDateTimestamp == checkinDateTimestamp;
//
//	return status;
//}
