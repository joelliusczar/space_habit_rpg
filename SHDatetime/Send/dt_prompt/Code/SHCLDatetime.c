#include "SHCLDatetime.h"
#include "SHUtilConstants.h"
#include "SHArray.h"
#include "SHGenAlgos.h"
#include "SHDatetime_struct.h"
#include "SHDatetimeFuncs.h"
#include "SHDatetime_addition.h"
#include <stdlib.h>
#include <stdbool.h>


typedef struct SHTimeshift SHTimeshift;
SH_DEF_RESIZE_ARR(SHTimeshift)

static struct SHDatetime _dt;
static struct SHDatetime _dtb;

static int32_t _datesParsed = 0;
static int32_t _timesParsed = 0;

static int32_t _choiceHash = 0;
//command options get hashed to an interger, these are the precalculated hashes
static const int32_t _dt_ts = 5;
static const int32_t _ts_dt = 6;
static const int32_t _dtadd = 8;
static const int32_t _ddiff = 32;
static const int32_t _weekday = 30;
static const int32_t _sdiff = 14;


static bool _shouldUseBackupVar(){
	return ((_datesParsed > 0 || _timesParsed > 0) &&
		(_choiceHash == _ddiff || _choiceHash == _sdiff));
}

static void _printHelpMenu(){
	printf("dt_prompt ts_dt -ts <timestamp>\n");
	printf("\t:Converts the given timestamp to year-month-day hour:minute:second tz offset:offset format\n");
}

static SHErrorCode _argsToTimeshifts(int32_t argc,char *argv[], struct SHDatetime *dt, int32_t *lastIdx
	,int32_t *allocSize)
{
	int32_t tmpIdx = *lastIdx;
	if((argc -tmpIdx) >= 5){
		int32_t shiftIdx = dt->shiftLen-1;
		if(!dt->shifts){
			dt->shifts = malloc(sizeof(struct SHTimeshift) * (*allocSize));
			if(!shift) goto allocErr;
			dt->shiftLen = 0;
			shiftIdx = 0;
		}
		if(dt->shiftLen == *allocSize){
			struct SHTimeshift *tmp = dt->shifts;
			int32_t oldSize = *allocSize;
			*allocSize <<= 1;
			dt->shifts = SH_resizeArr(SHTimeshift)(tmp, oldSize, *allocSize);
			SH_cleanup(&tmp);
		}
		struct SHTimeshift *shift = malloc(sizeof(struct SHTimeshift));
		if(!shift) goto allocErr;
		char *ptr;
		shift->month = strtol(argv[tmpIdx++],&ptr,10);
		shift->day = strtol(argv[tmpIdx++],&ptr,10);
		shift->hour = strtol(argv[tmpIdx++],&ptr,10);
		shift->minute = strtol(argv[tmpIdx++],&ptr,10);
		shift->adjustment = strtol(argv[tmpIdx++],&ptr,10);
		SH_freeSHTimeshift(&dt->shifts[shiftIdx]);
		dt->shifts[shiftIdx] = *shift;
		dt->shiftLen++;
	}
	else {
		return SH_GEN_ERROR;
	}
	*lastIdx = tmpIdx;
	return SH_NO_ERROR;
	allocErr:
		return SH_ALLOC_MEM;
}

static SHErrorCode _loadDateArgsIntoDt(int32_t argc, char *argv[], struct SHDatetime *dt, int32_t *lastIdx){
	SHErrorCode status = SH_NO_ERROR;
	int32_t tmpIdx = *lastIdx;
	if((argc -tmpIdx) < 3) return status;
	char *ptr;
	SH_dtSetYear(dt, strtol(argv[tmpIdx++],&ptr, 10));
	if(*ptr != '\0') return SH_GEN_ERROR;
	SH_dtSetMonth(dt, strtol(argv[tmpIdx++],&ptr, 10));
	if(*ptr != '\0') return SH_GEN_ERROR;
	SH_dtSetDay(dt, strtol(argv[tmpIdx++],&ptr, 10));
	if(*ptr != '\0') return SH_GEN_ERROR;
	if((argc -tmpIdx) > 0){
		int32_t tzOffset = strtol(argv[tmpIdx],&ptr, 10);
		if(*ptr != '\0') {
			*lastIdx = tmpIdx;
			return status;
		}
		SH_dtSetTimezoneOffset(dt, tzOffset);
		tmpIdx++;
	}
	*lastIdx = tmpIdx;
	return status;
}

static SHErrorCode _loadTimeArgsIntoDt(int32_t argc, char *argv[], struct SHDatetime *dt, int32_t *lastIdx){
	SHErrorCode status = SH_NO_ERROR;
	int32_t tmpIdx = *lastIdx;
	if((argc - tmpIdx) < 3) return status;
	char *ptr = NULL;

	SH_dtSetHour(dt, strtol(argv[tmpIdx++], &ptr, 10));
	if(*ptr != '\0') return SH_GEN_ERROR;
	SH_dtSetMinute(dt, strtol(argv[tmpIdx++], &ptr, 10));
	if(*ptr != '\0') return SH_GEN_ERROR;
	SH_dtSetSecond(dt, strtol(argv[tmpIdx++], &ptr, 10));
	if(*ptr != '\0') return SH_GEN_ERROR;
	*lastIdx = tmpIdx;
	return status;
}


static SHErrorCode _loadTimestampArgs(int32_t argc, char *argv[], double *timestamp, int32_t *tzOffset,
	int32_t *lastIdx)
{
	int32_t tmpIdx = *lastIdx;
	if((argc - tmpIdx) < 1) return SH_NO_ERROR;
	char *ptr = NULL;
	*timestamp = strtol(argv[tmpIdx++], &ptr, 10);
	if(*ptr != '\0') return SH_GEN_ERROR;
	*tzOffset = 0;
	if((argc -tmpIdx) > 0){
		*tzOffset = strtol(argv[tmpIdx], &ptr, 10);
		if(*ptr != '\0') {
			*tzOffset = 0;
			*lastIdx = tmpIdx;
			return SH_NO_ERROR;
		}
		tmpIdx++;
	}
	*lastIdx = tmpIdx;
	return SH_NO_ERROR;
}


static SHErrorCode _loadAddUnitArgs(int32_t argc, char *argv[], int64_t *add, int32_t *lastIdx){
	int32_t tmpIdx = *lastIdx;
	if((argc -tmpIdx) < 1) return SH_NO_ERROR;
	char *ptr = NULL;
	*add = strtol(argv[tmpIdx++],&ptr,10);
	if(*ptr != '\0') return SH_GEN_ERROR;
	*lastIdx = tmpIdx;
	return SH_NO_ERROR;
}


static SHErrorCode _loadDateTimeArgs(int32_t argc, char *argv[],
	SHErrorCode (*load_fp)(int32_t,char **, struct SHDatetime*,int32_t *),
	int32_t *parseCount, int32_t *lastIdx)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime *dtPt = (*parseCount > 0
		&& (_choiceHash == _ddiff || _choiceHash == _sdiff))
		? &_dtb :
		&_dt;
	if((status = load_fp(argc, argv, dtPt, lastIdx)) != SH_NO_ERROR) {
		goto fnExit;
	}
	(*parseCount)++;
	fnExit:
		return status;
}

static SHErrorCode _loadTimeAddOptionArg(int32_t argc,char *argv[], SHTimeAdjustOptions *opt,int32_t *lastIdx){
	*opt = 0;
	int32_t tmpIdx = *lastIdx;
	if((argc -tmpIdx) < 1) return SH_NO_ERROR;
	if(!strcmp(argv[tmpIdx],"-stf")){
		*opt = SH_TIME_ADJUST_SHIFT_FWD;
	}
	else if(!strcmp(argv[tmpIdx],"-stb")){
		*opt = SH_TIME_ADJUST_SHIFT_BKD;
	}
	else if(!strcmp(argv[tmpIdx],"-e")){
		*opt = SH_TIME_ADJUST_ERROR;
	}else if(!strcmp(argv[tmpIdx],"-smp")){
		*opt = SH_TIME_ADJUST_SIMPLE;
	}
	else{
		return SH_GEN_ERROR;
	}
	tmpIdx++;
	*lastIdx = tmpIdx;
	return SH_NO_ERROR;
}

static SHErrorCode _loadDtPart(int32_t argc,char *argv[], int32_t *lastIdx){
	int32_t allocSize = 4;
	SHErrorCode status = SH_NO_ERROR;
	while((argc - (*lastIdx)) > 0){
		if(!strcmp(argv[*lastIdx],"-d")){
			(*lastIdx)++;
			if((status = _loadDateTimeArgs(argc,argv, &_loadDateArgsIntoDt, &_datesParsed, lastIdx))
				!= SH_NO_ERROR)
			{
				goto fnExit;
			}
			continue;
		}
		if(!strcmp(argv[*lastIdx],"-t")){
			(*lastIdx)++;
			if((status = _loadDateTimeArgs(argc,argv,&_loadTimeArgsIntoDt,&_timesParsed, lastIdx))
				!= SH_NO_ERROR)
			{
				goto fnExit;
			}
			continue;
		}
		struct SHDatetime *dtPt = _shouldUseBackupVar() ? &_dtb : &_dt;
		if(!strcmp(argv[*lastIdx],"-tz")){
			(*lastIdx)++;
			if((status = _argsToTimeshifts(argc, argv,dtPt, &allocSize, lastIdx))
				!= SH_NO_ERROR)
			{
				goto fnExit;
			}

			continue;
		}
		if(!strcmp(argv[*lastIdx],"-ts")){
			double ts = 0;
			int32_t tzOffset = 0;
			if((status = _loadTimestampArgs(argc,argv,&ts,&tzOffset, lastIdx)) != SH_NO_ERROR) {
				goto fnExit;
			}
			if((status = SH_timestampToDt(ts, tzOffset, dtPt)) != SH_NO_ERROR) {
				goto fnExit;
			}

			_datesParsed++;
			_timesParsed++;
			continue;
		}
		break;
	}
	fnExit:
		return status;
}


static SHErrorCode _loadAddArgs(int32_t argc,char *argv[], int32_t *lastIdx){
	int32_t tmpIdx = *lastIdx;
	SHErrorCode status = SH_NO_ERROR;
	if(argc-tmpIdx < 1) return status;
	SHTimeAdjustOptions opt = 0;
	SHErrorCode (*adder)(struct SHDatetime *,int64_t, SHTimeAdjustOptions) = 0;
	if(_choiceHash == _dtadd){
		int64_t add = 0;
		while((argc - tmpIdx) > 0){
			if(!strcmp(argv[tmpIdx],"d")){
				tmpIdx++;
				adder = &SH_addDaysToDt;
			}
			else if(!strcmp(argv[tmpIdx],"m")){
				tmpIdx++;
				adder = &SH_addMonthsToDt;
			}
			else if(!strcmp(argv[tmpIdx],"y")){
				tmpIdx++;
				adder = &SH_addYearsToDt;
			}
			else if(!strcmp(argv[tmpIdx],"-opt")){
				tmpIdx++;
				if((status = _loadTimeAddOptionArg(argc,argv,&opt,&tmpIdx)) != SH_NO_ERROR) {
					goto fnExit;
				}
				continue;
			}
			if((status = _loadAddUnitArgs(argc,argv,&add,&tmpIdx)) != SH_NO_ERROR) {
				goto fnExit;
			}
			if(adder) {
				if((status = adder(&_dt,add,opt)) != SH_NO_ERROR) {
					goto fnExit;
				}
			}

			break;
		}
	}
	fnExit:
		*lastIdx = tmpIdx;
		return status;
}

static SHErrorCode _loadAllArgs(int32_t argc,char *argv[]){
	_choiceHash = SH_calcStrHash(argv[1]) % 33;
	int32_t idx = 2;
	SHErrorCode status = 0;
	_dt = (struct SHDatetime){0};
	_dtb = (struct SHDatetime){0};
	if((status = _loadDtPart(argc,argv, &idx)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = _loadAddArgs(argc,argv, &idx)) != SH_NO_ERROR) {

	}
	fnExit:
		return status;
}


SHErrorCode SHCL_dtToTimestamp(int32_t argc,char *argv[], double* ans){
	SHErrorCode status = SH_NO_ERROR;
	if((status = _loadAllArgs(argc,argv)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(&_dt, ans)) != SH_NO_ERROR) {
		goto fnExit;
	}
	fnExit:
	return status;
}


SHErrorCode SHCL_timestampToDt(int32_t argc, char *argv[], struct SHDatetime *dtLocal){
	SHErrorCode status = SH_NO_ERROR;
	if((status = _loadAllArgs(argc,argv)) != SH_NO_ERROR) {
		return status;
	}
	*dtLocal = _dt;
	return SH_NO_ERROR;
}


SHErrorCode SHCL_dtAdd(int32_t argc,char *argv[], struct SHDatetime *dtLocal){
	SHErrorCode status = SH_NO_ERROR;
	//not sure if this has ever been tested
	if((status = _loadAllArgs(argc,argv)) != SH_NO_ERROR) {
		return status;
	}
	*dtLocal = _dt;
	return SH_NO_ERROR;
}


SHErrorCode SHCL_dayDiff(int32_t argc,char *argv[], int64_t *ans){
	SHErrorCode status = SH_NO_ERROR;
	if((status = _loadAllArgs(argc,argv)) != SH_NO_ERROR) {
		return status;
	}
	if((status = SH_dateDiffDays(&_dtb, &_dt, ans)) != SH_NO_ERROR) {
		return status;
	}
	return status;
}

SHErrorCode SHCL_secDiff(int32_t argc,char *argv[],double *ans){
	SHErrorCode status = SH_NO_ERROR;
	if((status = _loadAllArgs(argc,argv)) != SH_NO_ERROR) {
		return status;
	}
	if((status = SH_dateDiffSeconds(&_dtb,&_dt,ans)) != SH_NO_ERROR) {
		return status;
	}
	return status;
}

SHErrorCode SHCL_calcWeekdayIdx(int32_t argc,char *argv[], int32_t *ans){
	SHErrorCode status = SH_NO_ERROR;
	if((status = _loadAllArgs(argc,argv)) != SH_NO_ERROR) {
		return status;
	}

	*ans = SH_weekdayIdx(&_dt,0);
	return SH_NO_ERROR;
}


SHErrorCode SHCL_selectChoice(int32_t argc,char *argv[]){
	if(argc < 2){
		printf("No input was given\n");
		return SH_GEN_ERROR;
	}
	if(!strcmp(argv[1],"-h")){
		_printHelpMenu();
		return SH_NO_ERROR;
	}
	printf("past\n");
	_choiceHash = SH_calcStrHash(argv[1]) % 33;
	SHErrorCode status = SH_NO_ERROR;
	if(_choiceHash == _dt_ts){
		double ans = 0;
		if((status = SHCL_dtToTimestamp(argc,argv,&ans)) != SH_NO_ERROR) {
			return status;
		}
		printf("%f\n",ans);
		return SH_NO_ERROR;
	}
	if(_choiceHash == _ts_dt){
		struct SHDatetime ans;
		if((status = SHCL_timestampToDt(argc, argv, &ans)) != SH_NO_ERROR) {
			return status;
		}
		printf("%"PRId64 "-%d-%d %d:%d:%d tz offset: %d\n",
			_dt.year,_dt.month,_dt.day,_dt.hour, _dt.minute,_dt.second
			,_dt.timezoneOffset);
		return SH_NO_ERROR;
	}
	if(_choiceHash == _dtadd){
		struct SHDatetime ans;
		if((status = SHCL_dtAdd(argc, argv, &ans)) != SH_NO_ERROR) {
			return status;
		}

		printf("%"PRId64 "- %d - %d %d:%d:%d tz offset: %d\n",
			_dt.year,_dt.month,_dt.day,_dt.hour,_dt.minute,_dt.second
			,_dt.timezoneOffset);
		return SH_NO_ERROR;
	}
	if(_choiceHash == _ddiff){
		int64_t ans = 0;
		if((status = SHCL_dayDiff(argc,argv, &ans)) != SH_NO_ERROR) {
			return status;
		}
		printf("%lld\n",ans);
		return SH_NO_ERROR;
	}
	if(_choiceHash == _weekday){
		int32_t ans = SH_NOT_FOUND;
		if((status = SHCL_calcWeekdayIdx(argc, argv, &ans)) != SH_NO_ERROR) {
			return status;
		}
		printf("%d\n",ans);
		return SH_NO_ERROR;
	}
	if(_choiceHash == _sdiff){
		double ans = 0;
		if((status = SHCL_secDiff(argc,argv,&ans)) != SH_NO_ERROR) {
			return status;
		}
		printf("%fn",ans);
		return SH_NO_ERROR;
	}
	return SH_GEN_ERROR;
}


static void _cleanup(){
	//SH_freeSHDatetime(&_dt,1);
}

SHErrorCode SHCL_datetimeCalcEntryFn(int32_t argc,char *argv[]){
	if(argc < 2){
		printf("No input was given\n");
		return SH_GEN_ERROR;
	}
	SHErrorCode status = SHCL_selectChoice(argc, argv);
	_cleanup();
	if(status != SH_NO_ERROR){
		printf("Error!\n");
		return status;
	}
	return SH_NO_ERROR;
}
