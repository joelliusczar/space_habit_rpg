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
#include "SHDateCompare.h"
#include <stdlib.h>
#include <float.h>
#include <assert.h>


typedef struct SHWeekIntervalPoint SHWeekIntervalPoint;
//these define our find algorithms for specific types
//we aren't actually doing anything with the int param
SH_DEF_FIND_IDX_REV(SHWeekIntervalPoint,int32_t,*,,);
SH_DEF_FIND_IDX(SHWeekIntervalPoint,int32_t,*,,);

struct SHMissedDaysInfo {
	int32_t calculatedDateWeekdayIdx;
	int32_t savedDateWeekdayIdx;
	int32_t firstPartialWeekCount;
	int32_t fullWeekActiveDaysCount;
	int32_t lastPartialWeekCount;
	int64_t fullWeekCount;
};


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
	SH_dtSetTimezoneOffset(dt, 0);
	/*
		It's fine that the time of the day is technically in gmt because
		we only care that it is the start of the day.
		I'm setting the time to 0 but I'm not sure it actually matters.
		The only reason we care about dayStartTime, is because
		we need it to figure out if a day should be considered today, or day before.
		For example, if our dayStart is at 6am, we want anything that occurs
		on tuesday before 6am to be considered part of Monday. In our example,
		tuesday doesn't officially begin until 6am. #dueDateLogic
	*/
	int32_t timeOfDayInSeconds = (int32_t)timeOfDay;
	if(timeOfDayInSeconds >= dayStartTime) {
		SH_dtSetToTimeOfDay(dt, 0);
		goto fnExit;
	}
	
	/*
		if it is before our day start time, then it is the day before, so we subtract a day.
		//didn't want to free dt->shifts in case it's used on another pointer, but also
		//did not want to null it out and possibly loose a reference to it, creating a memory leak
		
	*/
	SH_dtSetToTimeOfDay(dt, 0);
	dt->shiftLen = 0;
	SH_addDaysToDt(dt, -1, SH_TIME_ADJUST_NO_OPTION);
	fnExit:
		return status;
}


/*
		#dueDateLogic
		we don't care the time of the day on prev use date.
		We only care if, for example, it was on a wednesday
		or which wednesday it occured.
		But we still need to normalize it
		@dueDateLogic1
	*/
static void _normalizeDatetime(struct SHDatetime *dt) {
	SH_dtSetTimezoneOffset(dt, 0);
	SH_dtSetToTimeOfDay(dt, 0);
}


/*
	I'm not concerned with perfect accuracy of previousDueDate in the sense
	that I don't care that it occured in a different timezone.
	I am going to assume that previousDueDate occured in the current timezone.
	Because again, I am not concerned with perfect time accuracy because if the previous duedate
	was Wednesday, Jan 10, and today is Jan 17; I don't care that previous due date
	was 604,800 seconds ago. I care that it was 1 Wednesday ago.
	I care about how it fits into the day interval scheme
*/
static SHErrorCode _previousDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans)
{
	shLog("previousDueDate_WEEKLY");
	SHErrorCode status = SH_NO_ERROR;
	double useDateTimestamp = 0;
	double lastCheckinTimestamp = 1;
	SH_dtToTimestamp(useDate,&useDateTimestamp);
	SH_dtToTimestamp(context->savedPrevDate,&lastCheckinTimestamp);

	if(lastCheckinTimestamp >= useDateTimestamp) {
		status = SH_ILLEGAL_INPUTS;
		SH_notifyOfError(SH_INVALID_STATE, "Checkindate needs to be after savedPrevDate");
		goto fnExit;
	}

	int32_t lastDayIdx = SH_NOT_FOUND;
	if((lastDayIdx = SH_weekdayIdx(context->savedPrevDate, context->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	if(!context->intervalPoints->days[lastDayIdx].isDayActive){
		SH_notifyOfError(SH_INVALID_STATE, "Previous due date is on an non active day.");
		status = SH_INVALID_STATE;
		goto fnExit;
	}
	struct SHDatetime firstDayOfFirstWeek = *context->savedPrevDate;
	SH_addDaysToDt(&firstDayOfFirstWeek, -lastDayIdx, SH_TIME_ADJUST_NO_OPTION);
	int64_t daySpan = 0;
	if((status = SH_dateDiffDays(&firstDayOfFirstWeek, useDate, &daySpan)) != SH_NO_ERROR) {
		goto fnExit;
	}
	int32_t checkinDayIdx = SH_weekdayIdx(useDate, context->weekStartOffset);
	int64_t firstSunToPrevSunSpan = daySpan - checkinDayIdx;
	bool isActiveWeek = _distanceFromActiveWeek(firstSunToPrevSunSpan, context->intervalSize) == 0;
	int32_t prevDayIdx = _findPrevDayIdxInWeek(isActiveWeek, checkinDayIdx, context->intervalPoints);
	firstSunToPrevSunSpan -= (_offsetForSameWeek(isActiveWeek, checkinDayIdx, prevDayIdx));
	int64_t sunOfPrevActionWeek = firstSunToPrevSunSpan - _distanceFromActiveWeek(firstSunToPrevSunSpan,
		context->intervalSize);
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


SHErrorCode SH_previousDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime useDatePrepared = *useDate;
	struct SHDatetime savedPrevDatePrepared = *context->savedPrevDate;
	struct SHDueDateWeeklyContext contextCopy = *context;
	contextCopy.savedPrevDate = &savedPrevDatePrepared;

	_normalizeDatetime(&savedPrevDatePrepared);
	if((status = _prepareDatetimeForCalculations(&useDatePrepared, context->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	if((status = _previousDueDate_WEEKLY(&useDatePrepared, &contextCopy, ans)) != SH_NO_ERROR) {
		return status;
	}
	/* search for #dueDateLogic */
	SH_dtSetTimezoneOffset(ans, useDate->timezoneOffset);
	return status;
}


static SHErrorCode _bothWeeklyDueDatesFromLastDueDate(struct SHDatetime *useDate,
	struct SHDueDateWeeklyContext *context, struct SHDatetime **ans, int32_t *ansLen)
{
	shLog("bothWeeklyDueDatesFromLastDueDate");
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime previousDate;

	if((status = _previousDueDate_WEEKLY(useDate, context, &previousDate)) != SH_NO_ERROR) {
		goto fnExit;
	}

	int32_t prevDayIdx = SH_weekdayIdx(&previousDate, context->weekStartOffset);
	struct SHDatetime firstDayOfPrevWeek = previousDate;
	SH_addDaysToDt(&firstDayOfPrevWeek, -1 * prevDayIdx, SH_TIME_ADJUST_NO_OPTION);
	int64_t daySpan = 0;
	SH_dateDiffDays(&firstDayOfPrevWeek, useDate, &daySpan);
	int32_t checkinDayIdx = SH_weekdayIdx(useDate, context->weekStartOffset);
	int64_t prevSunToThisSunSpan = daySpan - checkinDayIdx;
	int64_t weekCount = (_distanceFromActiveWeek(prevSunToThisSunSpan, context->intervalSize) / SH_DAYS_IN_WEEK);
	int64_t nextActiveWeek = prevSunToThisSunSpan + (((context->intervalSize - weekCount) %
		context->intervalSize) * SH_DAYS_IN_WEEK);
	int32_t weekStartIdx = weekCount == 0 ? checkinDayIdx : 0;
	int32_t nextDayIdx = _findNextDayIdx(weekStartIdx, context->intervalPoints);
	int64_t sameWeekOffset = nextDayIdx < checkinDayIdx && weekCount == 0 ?
		context->intervalSize * SH_DAYS_IN_WEEK : 0;
	struct SHDatetime nextDueDate = firstDayOfPrevWeek;
	SH_addDaysToDt(&nextDueDate, nextActiveWeek + nextDayIdx + sameWeekOffset, SH_TIME_ADJUST_NO_OPTION);
	
	struct SHDatetime *resultDates = malloc(sizeof(struct SHDatetime) * 2);
	if(!resultDates) {
		status = SH_ALLOC_NO_MEM;
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


static SHErrorCode _nextDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans)
{
	shLog("nextDueDate_WEEKLY\n");
	SHErrorCode status = SH_NO_ERROR;
	int32_t ansLen = 0;
	struct SHDatetime *resultPair;
	if((status = _bothWeeklyDueDatesFromLastDueDate(useDate, context, &resultPair, &ansLen)) != SH_NO_ERROR) {
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
	SH_dtSetToTimeOfDay(&useDateStart, context->dayStartHour);
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
			"useDate: %s Interval Size:%d",ansStr, checkinStr, context->intervalSize);
		SH_notifyOfError(status, frmtErrMsg);
		goto cleanup;
	}
#endif
	goto cleanup; //this is easier than wrapping the cleanup label in an ignore warning block
	cleanup:
		SH_freeSHTimeshift(&resultPair[0].shifts);
		SH_freeSHTimeshift(&resultPair[1].shifts);
		SH_freeSHDatetime(&resultPair);
	fnExit:
		return status;
}



SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(struct SHDatetime *useDate,
	struct SHDueDateWeeklyContext *context, struct SHDatetime **ans, int32_t *ansLen)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime useDatePrepared = *useDate;
	struct SHDatetime savedPrevDatePrepared = *context->savedPrevDate;
	struct SHDueDateWeeklyContext contextCopy = *context;
	contextCopy.savedPrevDate = &savedPrevDatePrepared;

	_normalizeDatetime(&savedPrevDatePrepared);
	if((status = _prepareDatetimeForCalculations(&useDatePrepared, context->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	if((status = _bothWeeklyDueDatesFromLastDueDate(&useDatePrepared, &contextCopy, ans, ansLen)) != SH_NO_ERROR) {
		return status;
	}
	struct SHDatetime *results = *ans;
	for(int32_t idx = 0; idx < *ansLen; idx++) {
		/* search for #dueDateLogic*/
		SH_dtSetTimezoneOffset(&results[idx], useDate->timezoneOffset);
	}
	
	return status;
}

/*
	When calculating the next due date, we assume a timezone agnostic zone
	because, for this apps sake, when we I say that a task is due next monday,
	I'm not necessarily referencing an exact time. If I was, I'd be aiming at
	a moving target of sorts. So, I'm just aiming at Monday, whenver Monday occurs
	in your timezone

	#dueDateLogic
*/
SHErrorCode SH_nextDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime useDatePrepared = *useDate;
	struct SHDatetime savedPrevDatePrepared = *context->savedPrevDate;
	struct SHDueDateWeeklyContext contextCopy = *context;
	contextCopy.savedPrevDate = &savedPrevDatePrepared;
	
	
	_normalizeDatetime(&savedPrevDatePrepared);
	/*
		#dueDateLogic
		in contrast to savedPrevDate which should only be stored with year, month, and day (hour, min, and sec all 0);
		useDate could literally be at any moment of the day, so we need to, not only normalize it,
		but make sure it's calculated as the right day according to when the user wants their day to start
		see @dueDateLogic1
	*/
	if((status = _prepareDatetimeForCalculations(&useDatePrepared, context->dayStartHour)) != SH_NO_ERROR) {
		return status;
	}
	if((status = _nextDueDate_WEEKLY(&useDatePrepared, &contextCopy, ans)) != SH_NO_ERROR) {
		return status;
	}
	/*
		results will be set to the timezone of the useDate becuase the useDate is assumed to
		have the current local timezone #dueDateLogic
	*/
	SH_dtSetTimezoneOffset(ans, useDate->timezoneOffset);
	return status;
}


SHErrorCode SH_isDateADueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	bool *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	*ans = false;
	shLog("sh_isDateADueDate_WEEKLY\n");
	struct SHDatetime nextDueDate;
	if((status = SH_nextDueDate_WEEKLY(useDate, context, &nextDueDate)) != SH_NO_ERROR) {
		SH_notifyOfError(status, "Could not determine if date is a due date");
		return status;
	}
	double nextDueDateTimestamp = 0;
	SH_dtToTimestamp(&nextDueDate, &nextDueDateTimestamp);

	struct SHDatetime useDatePrepared = *useDate;
	SH_dtSetTimezoneOffset(&useDatePrepared, 0);
	SH_dtSetToTimeOfDay(&useDatePrepared, 0);
	SH_dtSetTimezoneOffset(&useDatePrepared, nextDueDate.timezoneOffset);
	double useDateTimestamp = -1; //any value that's different from nextDueDateTimestamp, i.e. not 0

	SH_dtToTimestamp(&useDatePrepared, &useDateTimestamp);

	*ans = nextDueDateTimestamp == useDateTimestamp;

	return status;
}


SHErrorCode SH_isWeekActiveForDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	bool *ans) {
	SHErrorCode status = SH_NO_ERROR;
	*ans = false;
	
	
	bool areSameWeek = false;
	if((status = SH_areSameWeek(useDate, context->savedPrevDate, context->weekStartOffset, &areSameWeek))
		!= SH_NO_ERROR)
	{
		goto fnExit;
	}
	if(areSameWeek) {
		*ans = true;
		goto fnExit;
	}
	struct SHDatetime cursorDt = *useDate;
	if((status = SH_weekStart(&cursorDt, context->weekStartOffset)) != SH_NO_ERROR) {
		goto fnExit;
	}
	//even if savedPrevDate is off, we're using it as a sort of reference point
	// that its week is always active #activeDayMath
	struct SHDatetime	previousDueDate = *context->savedPrevDate;
	struct SHDueDateWeeklyContext inputCopy = *context; //shallow copy
	SH_setUseDateToLastActive(&previousDueDate, &inputCopy);
	inputCopy.savedPrevDate = &previousDueDate;

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


/*
This function assumes that the week that the use date falls on is active. Because it is meant to be used
in the case when when we don't actually have a last due date #activeDayMath #dueDateLogic
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



static SHErrorCode _missedDays_sameWeek(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	int64_t *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	*ans = 0;
	int32_t useDateWeekdayIdx = SH_NOT_FOUND;
	if((useDateWeekdayIdx = SH_weekdayIdx(useDate, context->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	int32_t savedDateWeekdayIdx = SH_NOT_FOUND;
	if((savedDateWeekdayIdx = SH_weekdayIdx(context->savedPrevDate, context->weekStartOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	*ans = SH_activeDaysCountInRange(context->intervalPoints, savedDateWeekdayIdx + 1,
		useDateWeekdayIdx - savedDateWeekdayIdx - 1);
	
	fnExit:
		return status;
}


static SHErrorCode _missedDays_setInfo(struct SHDatetime *calculatedPrevDueDate,
	struct SHDueDateWeeklyContext *context, struct SHMissedDaysInfo *info)
{
	SHErrorCode status = SH_NO_ERROR;
	info->calculatedDateWeekdayIdx = SH_NOT_FOUND;
	if((info->calculatedDateWeekdayIdx = SH_weekdayIdx(calculatedPrevDueDate, context->weekStartOffset))
		== SH_NOT_FOUND)
	{
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	info->savedDateWeekdayIdx = SH_NOT_FOUND;
	if((info->savedDateWeekdayIdx = SH_weekdayIdx(context->savedPrevDate, context->weekStartOffset))
		== SH_NOT_FOUND)
	{
		status = SH_INPUT_BAD_RESULTS;
		goto fnExit;
	}
	info->firstPartialWeekCount = SH_activeDaysCountInRange(context->intervalPoints, info->savedDateWeekdayIdx + 1,
		SH_DAYS_IN_WEEK - info->savedDateWeekdayIdx - 1);
	if(info->firstPartialWeekCount == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		SH_notifyOfError(status, "error while calculating active days count");
		goto fnExit; //only bother checking error on first, anything that will ruin the next 2 calls
		// nothing will ruin those calls that didn't ruin this call
	}
	info->fullWeekActiveDaysCount = SH_activeDaysCountInRange(context->intervalPoints, 0, SH_DAYS_IN_WEEK);
	info->lastPartialWeekCount = SH_activeDaysCountInRange(context->intervalPoints, 0,
		info->calculatedDateWeekdayIdx + 1);
	info->fullWeekCount = 0;
	if((status = SH_dateDiffFullWeeks(context->savedPrevDate, calculatedPrevDueDate, context->weekStartOffset,
		&info->fullWeekCount)) != SH_NO_ERROR)
	{ goto fnExit; }
	
	fnExit:
		return status;
}


SHErrorCode _missedDays(struct SHDueDateWeeklyContext *context,
	struct SHDatetime *calculatedPrevDueDate, int64_t *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHMissedDaysInfo info;
	if((status = _missedDays_setInfo(calculatedPrevDueDate, context, &info)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if(info.fullWeekCount < 1) {
		status = SH_LOGIC_MISROUTE;
		SH_notifyOfError(status, "This should have been handled earlier in the flow.");
	}
	int64_t adjustedWeekCount = info.fullWeekCount / context->intervalSize;
	if(adjustedWeekCount == 0) {
		*ans = info.firstPartialWeekCount + info.lastPartialWeekCount;
		goto fnExit;
	}
	else {
		*ans = info.firstPartialWeekCount + (info.fullWeekActiveDaysCount * adjustedWeekCount) +
			info.lastPartialWeekCount;
	}
	fnExit:
		return SH_NO_ERROR;
}


SHErrorCode SH_missedDays_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context, int64_t *ans) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime normalizedSaveDate = *context->savedPrevDate;
	struct SHDatetime preparedUseDate = *useDate;
	_normalizeDatetime(&normalizedSaveDate);
	_prepareDatetimeForCalculations(&preparedUseDate, context->dayStartHour);
	bool areDatesValid = false;
	if((status = SH_isDateAGTEDateB(&preparedUseDate, &normalizedSaveDate, &areDatesValid)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if(!areDatesValid) {
		status = SH_ILLEGAL_INPUTS;
		SH_notifyOfError(status, "useDate must be greater than the saved useDate");
		goto fnExit;
	}
	struct SHDueDateWeeklyContext contextCopy = *context;
	contextCopy.savedPrevDate	= &normalizedSaveDate;
	bool areSameWeek = false;
	if((status = SH_areSameWeek(&preparedUseDate, contextCopy.savedPrevDate, contextCopy.weekStartOffset,
		&areSameWeek)) != SH_NO_ERROR)
	{
		goto fnExit;
	}
	if(areSameWeek) {
		status = _missedDays_sameWeek(&preparedUseDate, &contextCopy, ans);
		goto fnExit;
	}
	
	struct SHDatetime calculatedPrevDueDate;
	*ans = SH_NOT_FOUND;
	if((status = _previousDueDate_WEEKLY(useDate, &contextCopy, &calculatedPrevDueDate)) != SH_NO_ERROR) {
		goto fnExit;
	}
	_normalizeDatetime(&calculatedPrevDueDate);
	bool areEqual = false;
	if((status = SH_areDatesEqual(&calculatedPrevDueDate, &normalizedSaveDate, &areEqual)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if(areEqual) {
		*ans = 0;
		goto fnExit;
	}

	if(context->intervalSize < 1) {
		status = SH_ILLEGAL_INPUTS;
		goto fnExit;
	}
	if((status = SH_areSameWeek(&calculatedPrevDueDate, contextCopy.savedPrevDate, contextCopy.weekStartOffset,
		&areSameWeek)) != SH_NO_ERROR)
	{
		goto fnExit;
	}
	if(areSameWeek) {
		status = _missedDays_sameWeek(&calculatedPrevDueDate, &contextCopy, ans);
		(*ans)++;
		goto fnExit;
	}
	
	status = _missedDays(&contextCopy, &calculatedPrevDueDate, ans);

	
	
	fnExit:
		return status;
}
