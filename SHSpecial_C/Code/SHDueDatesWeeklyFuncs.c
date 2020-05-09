////
////	SHDaily_c.c
////	SHModels
////
////	Created by Joel Pridgen on 4/17/18.
////	Copyright © 2018 Joel Gillette. All rights reserved.
////
//
#include "SHDueDatesWeeklyFuncs.h"
#include "SHDTConstants.h"
#include "SHArray.h"
#include "SHErrorHandling.h"
#include "SHWeekIntervalPointsFuncs.h"
#include "SHDatetime_addition.h"
#include "SHDatetime_setters.h"
#include <stdlib.h>
#include <float.h>
#include <assert.h>


typedef struct SHWeekIntervalPoint SHWeekIntervalPoint;
//these define our find algorithms for specific types
//we aren't actually doing anything with the int param
SH_DEF_FIND_IDX_REV(SHWeekIntervalPoint,int32_t,*,,);
SH_DEF_FIND_IDX(SHWeekIntervalPoint,int32_t,*,,);


static bool _isDayActive(struct SHWeekIntervalPoint * intervalPoint,int64_t idx, int32_t blank){
	(void)idx;(void)blank;
	return intervalPoint->isDayActive;
}


static void _setDayCounts(int32_t *daysCounts, struct SHWeekIntervalPointList *activeDays, int32_t counter,
	bool isReverse)
{
	for(int32_t dayIdx = 0;dayIdx < SH_DAYS_IN_WEEK;dayIdx++){
		int32_t useIdx = isReverse? SH_DAYS_IN_WEEK - dayIdx -1 : dayIdx;
		counter++;
		daysCounts[useIdx] = counter;
		if(activeDays->days[useIdx].isDayActive){
			counter = 0;
		}
	}
}


void SH_fillWeek(int32_t *daysAheadCounts, int32_t *daysBeforeCounts,
	struct SHWeekIntervalPointList *intervalPoints)
{
	if(!(daysAheadCounts && daysBeforeCounts && intervalPoints)) return;
	for(int32_t dayIdx = 0;dayIdx < SH_WEEKLEN;dayIdx++){
		intervalPoints->days[dayIdx].forrange = daysAheadCounts[dayIdx];
		intervalPoints->days[dayIdx].backrange = daysBeforeCounts[dayIdx];
	}
}


static int32_t _distanceFromActiveWeek(int64_t weekNum, int32_t weekScaler){
	return weekNum % (weekScaler * SH_DAYS_IN_WEEK);
}


void SH_refreshWeek(struct SHWeekIntervalPointList *intervalPoints, int32_t intervalSize) {
	assert(intervalPoints);
	int32_t lastIdx = (int32_t)SH_findIdxRev(SHWeekIntervalPoint,int32_t)(intervalPoints->days, SH_DAYS_IN_WEEK, &_isDayActive,0);
	int32_t daysBefore = (SH_DAYS_IN_WEEK - lastIdx) + (intervalSize - 1) * SH_DAYS_IN_WEEK - 1;
	int32_t daysBeforeCounts[SH_WEEKLEN];
	_setDayCounts(daysBeforeCounts, intervalPoints, daysBefore, false);
	int32_t firstIdx = (int32_t)SH_findIdx(SHWeekIntervalPoint,int32_t)(intervalPoints->days, SH_DAYS_IN_WEEK,
		 &_isDayActive, 0);
	int32_t daysAhead = firstIdx + (intervalSize -1) * SH_DAYS_IN_WEEK;
	int32_t daysAheadCounts[SH_WEEKLEN];
	_setDayCounts(daysAheadCounts, intervalPoints, daysAhead, true);

	return SH_fillWeek(daysAheadCounts, daysBeforeCounts, intervalPoints);
}


static int32_t _findPrevDayIdxInWeek(bool isActiveWeek, int32_t checkinDayIdx,
	struct SHWeekIntervalPointList *week)
{
	int32_t prevDayIdx = SH_DAYS_IN_WEEK;
	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++){
		int32_t reverseDayIdx = isActiveWeek ?
			(SH_DAYS_IN_WEEK + checkinDayIdx - i -1) % SH_DAYS_IN_WEEK :
			SH_DAYS_IN_WEEK - i - 1;
		if(week->days[reverseDayIdx].isDayActive){
			prevDayIdx = reverseDayIdx;
			break;
		}
	}
	return prevDayIdx < SH_DAYS_IN_WEEK ? prevDayIdx : SH_NOT_FOUND;
}


static int32_t _findNextDayIdx(int32_t checkinDayIdx, struct SHWeekIntervalPointList* week){
	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++){
		int32_t dayIdx = (SH_DAYS_IN_WEEK + checkinDayIdx + i) % SH_DAYS_IN_WEEK;
		if(week->days[dayIdx].isDayActive){
			return dayIdx;
		}
	}
	return SH_NOT_FOUND;
}

static int32_t _offsetForSameWeek(bool isActiveWeek, int32_t inputDayIdx, int32_t prevDayIdx){
	/*
	 if checkin day is in active week but before all active days
	 push it back a week so that it get's the last active day of
	 the previous active weeks #activeDayMath
	 */
	return prevDayIdx > inputDayIdx || (prevDayIdx == inputDayIdx && isActiveWeek)
		? SH_DAYS_IN_WEEK : 0;
}


static SHErrorCode _prepareDatetimeForCalculations(struct SHDatetime *dt, int32_t dayStartTime) {
	SHErrorCode status = SH_NO_ERROR;
	double timeOfDay = 0;
	if((status = SH_dtToTimeOfDay(dt, &timeOfDay)) != SH_NO_ERROR) {
		goto fnExit;
	}
	int32_t timeOfDayInSeconds = (int32_t)timeOfDay;
	if(timeOfDayInSeconds >= dayStartTime) {
		SH_dtSetToTimeOfDay(dt, dayStartTime);
		goto fnExit;
	}
	SH_dtSetToTimeOfDay(dt, dayStartTime);
	dt->timezoneOffset = 0;

	//didn't want to free dt->shifts in case it's used on another pointer, but also
	//did not want to null it out and possibly loose a reference to it, creating a memory leak
	dt->shiftLen = 0;
	SH_addDaysToDt(dt, -1, SH_TIME_ADJUST_NO_OPTION);
	fnExit:
		return status;
}


static SHErrorCode _previousDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans)
{
	shLog("previousDueDate_WEEKLY");
	SHErrorCode status = SH_NO_ERROR;
	double useDateTimestamp = 0;
	double lastCheckinTimestamp = 1;
	SH_dtToTimestamp(useDate,&useDateTimestamp);
	SH_dtToTimestamp(input->prevUseDate,&lastCheckinTimestamp);

	if(lastCheckinTimestamp >= useDateTimestamp) {
		status = SH_ILLEGAL_INPUTS;
		SH_notifyOfError(SH_INVALID_STATE, "Checkindate needs to be after prevUseDate");
		goto fnExit;
	}

	int32_t lastDayIdx = SH_NOT_FOUND;
	if((lastDayIdx = SH_weekdayIdx(input->prevUseDate, input->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	if(!input->intervalPoints->days[lastDayIdx].isDayActive){
		SH_notifyOfError(SH_INVALID_STATE, "Previous due date is on an non active day.");
		status = SH_INVALID_STATE;
		goto fnExit;
	}
	struct SHDatetime firstDayOfFirstWeek = *input->prevUseDate;
	SH_addDaysToDt(&firstDayOfFirstWeek, -lastDayIdx, SH_TIME_ADJUST_NO_OPTION);
	int64_t daySpan = 0;
	if((status = SH_dateDiffDays(&firstDayOfFirstWeek, useDate, &daySpan)) != SH_NO_ERROR) {
		goto fnExit;
	}
	int32_t checkinDayIdx = SH_weekdayIdx(useDate, input->weekStartOffset);
	int64_t firstSunToPrevSunSpan = daySpan - checkinDayIdx;
	bool isActiveWeek = _distanceFromActiveWeek(firstSunToPrevSunSpan, input->intervalSize) == 0;
	int32_t prevDayIdx = _findPrevDayIdxInWeek(isActiveWeek, checkinDayIdx, input->intervalPoints);
	firstSunToPrevSunSpan -= (_offsetForSameWeek(isActiveWeek, checkinDayIdx, prevDayIdx));
	int64_t sunOfPrevActionWeek = firstSunToPrevSunSpan - _distanceFromActiveWeek(firstSunToPrevSunSpan,
		input->intervalSize);
	*ans = firstDayOfFirstWeek;
	if((status = SH_addDaysToDt(ans, sunOfPrevActionWeek + prevDayIdx, SH_TIME_ADJUST_NO_OPTION)) != SH_NO_ERROR) {
		goto fnExit;
	}
#ifdef SH_POST_DUE_DATE_CALC_CHECK
	double ansTimestamp = DBL_MAX;
	SH_dtToTimestamp(ans, &ansTimestamp);
	if(ansTimestamp > useDateTimestamp) {
		status = SH_INPUT_BAD_RESULTS;
		SH_notifyOfError(status, "The calculated answer for previous due date is after the checkindate");
		goto fnExit;
	}
#endif

	shLog("leaving previousDueDate_WEEKLY");
	fnExit:
		return status;
}


SHErrorCode SH_previousDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime useDatePrepared = *useDate;
	if((status = _prepareDatetimeForCalculations(input->prevUseDate, input->dayStartHour)) != SH_NO_ERROR) {
		 return status;
	}
	if((status = _prepareDatetimeForCalculations(&useDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	return _previousDueDate_WEEKLY(&useDatePrepared, input, ans);
}


static SHErrorCode _bothWeeklyDueDatesFromLastDueDate(struct SHDatetime *useDate,
	struct SHDueDateWeeklyContext *input, struct SHDatetime **ans, int32_t *ansLen)
{
	shLog("bothWeeklyDueDatesFromLastDueDate");
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime previousDate;

	if((status = _previousDueDate_WEEKLY(useDate, input, &previousDate)) != SH_NO_ERROR) {
		goto fnExit;
	}

	int32_t prevDayIdx = SH_weekdayIdx(&previousDate, input->weekStartOffset);
	struct SHDatetime firstDayOfPrevWeek = previousDate;
	SH_addDaysToDt(&firstDayOfPrevWeek, -1 * prevDayIdx, SH_TIME_ADJUST_NO_OPTION);
	int64_t daySpan = 0;
	SH_dateDiffDays(&firstDayOfPrevWeek, useDate, &daySpan);
	int32_t checkinDayIdx = SH_weekdayIdx(useDate, input->weekStartOffset);
	int64_t prevSunToThisSunSpan = daySpan - checkinDayIdx;
	int64_t weekCount = (_distanceFromActiveWeek(prevSunToThisSunSpan, input->intervalSize) / SH_DAYS_IN_WEEK);
	int64_t nextActiveWeek = prevSunToThisSunSpan + (((input->intervalSize - weekCount) %
		input->intervalSize) * SH_DAYS_IN_WEEK);
	int32_t weekStartIdx = weekCount == 0 ? checkinDayIdx : 0;
	int32_t nextDayIdx = _findNextDayIdx(weekStartIdx, input->intervalPoints);
	int64_t sameWeekOffset = nextDayIdx < checkinDayIdx && weekCount == 0 ? input->intervalSize * SH_DAYS_IN_WEEK : 0;
	struct SHDatetime nextDueDate = firstDayOfPrevWeek;
	SH_addDaysToDt(&nextDueDate, nextActiveWeek + nextDayIdx + sameWeekOffset, SH_TIME_ADJUST_NO_OPTION);
	
	struct SHDatetime *resultDates = malloc(sizeof(struct SHDatetime) * 2);
	if(!resultDates) {
		status = SH_ALLOC;
		SH_notifyOfError(status, "Failed to allocate memory for due dates");
		goto fnExit;
	}
	resultDates[0] = previousDate;
	resultDates[1] = nextDueDate;
	*ans = resultDates;
	*ansLen = 2;
	shLog("leaving bothWeeklyDueDatesFromLastDueDate");
	fnExit:
		return status;
}


static SHErrorCode _nextDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans)
{
	shLog("nextDueDate_WEEKLY\n");
	SHErrorCode status = SH_NO_ERROR;
	int32_t ansLen = 0;
	struct SHDatetime *resultPair;
	if((status = _bothWeeklyDueDatesFromLastDueDate(useDate, input, &resultPair, &ansLen)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if(!resultPair){
		status = SH_GEN_ERROR;
		SH_notifyOfError(status, "Error calculating next due date");
		goto fnExit;
	}
	*ans = resultPair[1];

	shLog("leaving nextDueDate_WEEKLY\n");

#ifdef SH_POST_DUE_DATE_CALC_CHECK
	struct SHDatetime useDateStart = *useDate;
	SH_dtSetToTimeOfDay(&useDateStart, input->dayStartHour);
	double ansTimestamp = DBL_MAX;
	double useDateTimestamp = 0;
	SH_dtToTimestamp(ans, &ansTimestamp);
	SH_dtToTimestamp(&useDateStart, &useDateTimestamp);
	if(ansTimestamp < useDateTimestamp) {
		status = SH_INPUT_BAD_RESULTS;
		char ansStr[75];
		char checkinStr[75];
		SH_DTToString(ans,ansStr);
		SH_DTToString(useDate,checkinStr);
		char frmtErrMsg[200];
		sprintf(frmtErrMsg, "The calculated next due date was before the check in date. Answer: %s "
			"useDate: %s Interval Size:%d",ansStr, checkinStr, input->intervalSize);
		SH_notifyOfError(status, frmtErrMsg);
		goto cleanup;
	}
#endif
	goto cleanup; //this is easier than wrapping the cleanup label in an ignore warning block
	cleanup:
		SH_freeSHDatetime(resultPair, ansLen);
	fnExit:
		return status;
}



SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(struct SHDatetime *useDate,
	struct SHDueDateWeeklyContext *input, struct SHDatetime **ans, int32_t *ansLen)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime prevUseDatePrepared = *input->prevUseDate;
	struct SHDatetime useDatePrepared = *useDate;
	if((status = _prepareDatetimeForCalculations(&prevUseDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	if((status = _prepareDatetimeForCalculations(&useDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	*input->prevUseDate = prevUseDatePrepared;
	return _bothWeeklyDueDatesFromLastDueDate(&useDatePrepared, input, ans, ansLen);
}


SHErrorCode SH_nextDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime prevUseDatePrepared = *input->prevUseDate;
	struct SHDatetime useDatePrepared = *useDate;
	if((status = _prepareDatetimeForCalculations(&prevUseDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
			return status;
	}
	if((status = _prepareDatetimeForCalculations(&useDatePrepared, input->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	*input->prevUseDate = prevUseDatePrepared;
	return _nextDueDate_WEEKLY(&useDatePrepared, input, ans);
}


SHErrorCode SH_isDateADueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	bool *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	shLog("sh_isDateADueDate_WEEKLY\n");
	struct SHDatetime nextDueDate;
	memset(&nextDueDate, 0, sizeof(struct SHDatetime));
	if((status = SH_nextDueDate_WEEKLY(useDate, input, &nextDueDate)) != SH_NO_ERROR) {
		SH_notifyOfError(status, "Could not determine if date is a due date");
		return status;
	}
	double nextDueDateTimestamp = 0;
	SH_dtToTimestamp(&nextDueDate, &nextDueDateTimestamp);

	struct SHDatetime useDatePrepared = *useDate;
	_prepareDatetimeForCalculations(&useDatePrepared, input->dayStartHour);
	double useDateTimestamp = -1; //any value that's different from nextDueDateTimestamp

	SH_dtToTimestamp(&useDatePrepared, &useDateTimestamp);

	*ans = nextDueDateTimestamp == useDateTimestamp;

	return status;
}


SHErrorCode SH_isWeekActiveForDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	bool *ans) {
	SHErrorCode status = SH_NO_ERROR;
	*ans = false;
	
	
	bool areSameWeek = false;
	if((status = SH_areSameWeek(useDate, input->prevUseDate, input->weekStartOffset, &areSameWeek))
		!= SH_NO_ERROR)
	{
		goto fnExit;
	}
	if(areSameWeek) {
		*ans = true;
		goto fnExit;
	}
	struct SHDatetime cursorDt = *useDate;
	if((status = SH_weekStart(&cursorDt, input->weekStartOffset)) != SH_NO_ERROR) {
		goto fnExit;
	}
	//even if prevUseDate is off, we're using it as a sort of reference point
	// that its week is always active #activeDayMath
	struct SHDatetime	previousDueDate = *input->prevUseDate;
	struct SHDueDateWeeklyContext inputCopy = *input; //shallow copy
	SH_setUseDateToLastActive(&previousDueDate, &inputCopy);
	inputCopy.prevUseDate = &previousDueDate;

	for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK; idx++) {
		if((status = SH_isDateADueDate_WEEKLY(&cursorDt, &inputCopy, ans)) != SH_NO_ERROR) {
			goto fnExit;
		}
		if(*ans) {
			goto fnExit;
		}
		SH_addDaysToDt(&cursorDt, 1, SH_TIME_ADJUST_NO_OPTION);
	}
	fnExit:
		return status;
}


SHErrorCode SH_missedDays(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *todayStart, int64_t *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime prevNextDueDate;
	*ans = SH_NOT_FOUND;
	if((status = SH_nextDueDate_WEEKLY(useDate, input, &prevNextDueDate)) != SH_NO_ERROR) {
		goto fnExit;
	}
	int32_t prevWeekdayIdx = SH_NOT_FOUND;
	if((prevWeekdayIdx = SH_weekdayIdx(&prevNextDueDate, input->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	int32_t useDateWeekdayIdx = SH_NOT_FOUND;
	if((useDateWeekdayIdx = SH_weekdayIdx(useDate, input->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	if(input->intervalSize < 1) {
		status = SH_ILLEGAL_INPUTS;
		goto fnExit;
	}
	if(input->intervalSize == 1) {
		bool areSameWeek = false;
		if((status = SH_areSameWeek(todayStart, input->prevUseDate, input->weekStartOffset, &areSameWeek))
			!= SH_NO_ERROR)
		{
			goto fnExit;
		}
		if(areSameWeek) {
			*ans = SH_activeDaysCountInRange(input->intervalPoints, prevWeekdayIdx, useDateWeekdayIdx - prevWeekdayIdx);
			goto fnExit;
		}
	}
	int64_t fullWeekCount = SH_NOT_FOUND;
	if((status = SH_dateDiffFullWeeks(&prevNextDueDate, input->prevUseDate, input->weekStartOffset, &fullWeekCount))
		!= SH_NO_ERROR) { goto fnExit; }
	int32_t firstPartialWeekCount = SH_activeDaysCountInRange(input->intervalPoints, prevWeekdayIdx,
		SH_DAYS_IN_WEEK - prevWeekdayIdx);
	if(firstPartialWeekCount == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		SH_notifyOfError(status, "error while calculating active days count");
		goto fnExit; //only bother checking error on first, anything that will ruin the next 2 calls
		// will first ruin this call
	}
	int32_t lastPartialWeekCount = SH_activeDaysCountInRange(input->intervalPoints, 0, useDateWeekdayIdx);
	int32_t fullWeekActiveDaysCount = SH_activeDaysCountInRange(input->intervalPoints, 0, SH_DAYS_IN_WEEK);
	*ans = firstPartialWeekCount + (fullWeekActiveDaysCount * fullWeekCount) + lastPartialWeekCount;
	
	fnExit:
		return status;
}

/*
This function assumes that the week that the use date falls on is active. Because it is meant to be used
in the case when when we don't actually have a last due date #activeDayMath
*/
SHErrorCode SH_setUseDateToLastActive(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context){
	SHErrorCode status = SH_NO_ERROR;
	int32_t weekendIdx = SH_NOT_FOUND;
	if((weekendIdx = SH_weekdayIdx(useDate, context->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	if(context->intervalPoints->days[weekendIdx].isDayActive) {
		goto fnExit;
	}
	int32_t prevDayIdx = SH_findPrevActiveDayIdx(context->intervalPoints, weekendIdx);
	if(prevDayIdx == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		SH_notifyOfError(status, "Could not find backup date because could not find weekday idx");
		goto fnExit;
	}
	bool isCurrentWeekActive = weekendIdx > prevDayIdx;
	int32_t diff = weekendIdx - prevDayIdx;
	int32_t daysAgo = diff;
	if(!isCurrentWeekActive) {
		daysAgo += context->intervalSize * SH_DAYS_IN_WEEK;
	}
	SH_addDaysToDt(useDate, -daysAgo, SH_TIME_ADJUST_NO_OPTION);
	fnExit:
		return status;
}
