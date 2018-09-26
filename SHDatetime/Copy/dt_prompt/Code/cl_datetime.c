#include <stdlib.h>
#include <stdbool.h>
#include "SHDatetime_struct.h"
#include "SHConstants.h"
#include "SHDatetime.h"
#include "SHArray.h"
#include "SHGenAlgos.h"
#include "ErrorHandling.h"
#include <inttypes.h>

DEF_RESIZE_ARR(Timeshift)

static SHDatetime dt;
static SHDatetime dtb;

static int datesParsed = 0;
static int timesParsed = 0;

static int choiceHash;
static const int dt_ts = 5;
static const int ts_dt = 6;
static const int dtadd = 8;
static const int ddiff = 32;
static const int weekday = 30;
static const int sdiff = 14;


static bool _shouldUseBackupVar(){
    return ((datesParsed > 0 || timesParsed > 0) && 
              (choiceHash == ddiff || choiceHash == sdiff));
}

static void _printHelpMenu(){
    printf("dt_prompt ts_dt -ts <timestamp>\n");
    printf("\t:Converts the given timestamp to year-month-day hour:minute:second tz offset:offset format\n");
}

static int _argsToTimeshifts(int argc,char *argv[],SHDatetime *dt,int lastIdx
  ,SHErrorCode* error,int *alsize){
    if((argc -lastIdx) >= 5){
        int shiftIdx = dt->shiftLen-1;
        if(!dt->shifts){
            dt->shifts = malloc(sizeof(Timeshift)*(*alsize));
            dt->shiftLen = 0;
            shiftIdx = 0;
        }
        if(dt->shiftLen == *alsize){
            Timeshift *tmp = dt->shifts;
            int oldSize = *alsize;
            *alsize <<= 1;
            dt->shifts = resizeArr(Timeshift)(tmp,oldSize,*alsize);
            free(tmp);
        }
        Timeshift *shift = malloc(sizeof(Timeshift));
        char *ptr;
        shift->month = strtol(argv[lastIdx++],&ptr,10);
        shift->day = strtol(argv[lastIdx++],&ptr,10);
        shift->hour = strtol(argv[lastIdx++],&ptr,10);
        shift->minute = strtol(argv[lastIdx++],&ptr,10);
        shift->adjustment = strtol(argv[lastIdx++],&ptr,10);
        dt->shifts[shiftIdx] = *shift;
        dt->shiftLen++;
    }
    else *error = GEN_ERROR;
    return lastIdx;
}

static int _loadDateArgsIntoDt(int argc,char *argv[],SHDatetime *dt,int lastIdx
  ,SHErrorCode* error){
    if((argc -lastIdx) < 3) return lastIdx;
    char *ptr;
    dt->year = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    dt->month = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    dt->day = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    if((argc -lastIdx) > 0){ 
        int tzOffset = strtol(argv[lastIdx],&ptr,10);
        if(*ptr != '\0') {
            return lastIdx;
        }
        dt->timezoneOffset = tzOffset;
        lastIdx++;
    }
    return lastIdx;
}

static int _loadTimeArgsIntoDt(int argc,char *argv[],SHDatetime *dt,int lastIdx
  ,SHErrorCode* error){
    if((argc -lastIdx) < 3) return lastIdx;
    char *ptr;
    dt->hour = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    dt->minute = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    dt->second = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    return lastIdx;
}

static int _loadTimestampArgs(int argc,char *argv[],double *timestamp,int *tzOffset
  ,int lastIdx,SHErrorCode* error){
    if((argc -lastIdx) < 1) return lastIdx;
    char *ptr;
    *timestamp = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    *tzOffset = 0;
    if((argc -lastIdx) > 0){ 
        *tzOffset = strtol(argv[lastIdx],&ptr,10);
        if(*ptr != '\0') {
            *tzOffset = 0;
            return lastIdx;
        }
        lastIdx++;
    }
    return lastIdx;
}

static int _loadAddUnitArgs(int argc,char *argv[],long *add,int lastIdx,SHErrorCode* error){
    if((argc -lastIdx) < 1) return lastIdx;
    char *ptr;
    *add = strtol(argv[lastIdx++],&ptr,10);
    if(*ptr != '\0') return setIndexErrorCode(GEN_ERROR,error);
    return lastIdx;
}

static int _loadDateTimeArgs(int argc,char *argv[],int lastIdx
  ,SHErrorCode* error, int (*load_fp)(int,char **,SHDatetime*,int,SHErrorCode*),int *parseCount){
    SHDatetime *dtPt = (*parseCount > 0 
      && (choiceHash == ddiff || choiceHash == sdiff))
      ? &dtb : &dt;
    lastIdx = load_fp(argc,argv,dtPt,lastIdx,error);
    if(*error) return setIndexErrorCode(GEN_ERROR,error);
    (*parseCount)++;
    return lastIdx;
}

static int _loadTimeAddOptionArg(int argc,char *argv[],TimeAdjustOptions *opt,int lastIdx
  ,SHErrorCode* error){
    *opt = 0;
    if((argc -lastIdx) < 1) return lastIdx;
    if(!strcmp(argv[lastIdx],"-stf")){
        *opt = SHIFT_FWD;
    }
    else if(!strcmp(argv[lastIdx],"-stb")){
        *opt = SHIFT_BKD;
    }
    else if(!strcmp(argv[lastIdx],"-e")){
        *opt = ERROR;
    }else if(!strcmp(argv[lastIdx],"-smp")){
        *opt = SIMPLE;
    }
    else{
        return setIndexErrorCode(GEN_ERROR,error);
    }
    
    return ++lastIdx;
}

static int _loadDtPart(int argc,char *argv[],int idx,SHErrorCode* error){
    int alsize = 4;
    
    while((argc - idx) > 0){
        if(*error) return setIndexErrorCode(*error,error);
        if(!strcmp(argv[idx],"-d")){
            idx = _loadDateTimeArgs(argc,argv,++idx,error
              ,&_loadDateArgsIntoDt,&datesParsed);
            continue;
        }
        if(!strcmp(argv[idx],"-t")){
            idx = _loadDateTimeArgs(argc,argv,++idx,error
              ,&_loadTimeArgsIntoDt,&timesParsed);
            continue;
        }
        SHDatetime *dtPt = _shouldUseBackupVar()?&dtb:&dt;
        if(!strcmp(argv[idx],"-tz")){
            idx = _argsToTimeshifts(argc,argv,dtPt,++idx,error,&alsize);
            continue;
        }
        if(!strcmp(argv[idx],"-ts")){
            double ts = 0;
            int tzOffset = 0;
            idx = _loadTimestampArgs(argc,argv,&ts,&tzOffset,++idx,error);
            tryTimestampToDt(ts,tzOffset,dtPt,error);
            datesParsed++;
            timesParsed++;
            continue;
        }
        break;
    }
    return idx;
}


static int _loadAddArgs(int argc,char *argv[],int idx,SHErrorCode* error){
    if(argc-idx < 1) return idx;
    TimeAdjustOptions opt = 0;
    bool (*adder)(SHDatetime *,int64_t,TimeAdjustOptions,SHErrorCode *) = 0;
    if(choiceHash == dtadd){
        long add = 0;
        while((argc - idx) > 0){
            if(*error) return setIndexErrorCode(*error,error);
            if(!strcmp(argv[idx],"d")){
                idx++;
                adder = &tryAddDaysToDtInPlace;
            }
            else if(!strcmp(argv[idx],"m")){
                idx++;
                adder = &tryAddMonthsToDtInPlace;
            }
            else if(!strcmp(argv[idx],"y")){
                idx++;
                adder = &tryAddYearsToDtInPlace;
            }
            else if(!strcmp(argv[idx],"-opt")){
                idx = _loadTimeAddOptionArg(argc,argv,&opt,++idx,error);
                if(*error) return setIndexErrorCode(*error,error);
                continue;
            }
            idx = _loadAddUnitArgs(argc,argv,&add,idx,error);
            if(*error) return setIndexErrorCode(*error,error);
            if(adder) adder(&dt,add,opt,(SHErrorCode *)error);
            else setIndexErrorCode(*error,error);
            if(*error) return setIndexErrorCode(*error,error);
            break;
        }
    }
    return idx;
}

static SHErrorCode _loadAllArgs(int argc,char *argv[]){
    choiceHash = calcStrHash(argv[1]) % 33;
    int idx = 2;
    SHErrorCode error = 0;
    initDt(&dt);
    initDt(&dtb);
    idx = _loadDtPart(argc,argv,idx,&error);
    if(error) return setErrorCode(error,&error);
    idx = _loadAddArgs(argc,argv,idx,&error);
    if(error) return setErrorCode(error,&error);
    return error;
}


double cl_dtToTimestamp(int argc,char *argv[],SHErrorCode* error){
    *error = _loadAllArgs(argc,argv);
    if(*error) return 0;
    double ts = 0;
    tryDtToTimestamp(&dt,&ts,error);
    return ts;
}


void cl_timestampToDt(int argc,char *argv[],SHErrorCode* error,SHDatetime *dt_l){
    *error = _loadAllArgs(argc,argv);
    *dt_l = dt;
}


void dtAdd(int argc,char *argv[],SHErrorCode* error,SHDatetime *dt_l){
    *error = _loadAllArgs(argc,argv);
    *dt_l = dt;
}


long dayDiff(int argc,char *argv[],SHErrorCode* error){
    *error = _loadAllArgs(argc,argv);
    if(*error) return 0;
    return dateDiffDays(&dt,&dtb,error);
}

double secDiff(int argc,char *argv[],SHErrorCode* error){
    *error = _loadAllArgs(argc,argv);
    if(*error) return 0;
    return dateDiffSecs(&dt,&dtb,error);
}

int cl_calcWeekdayIdx(int argc,char *argv[],SHErrorCode* error){
    *error = _loadAllArgs(argc,argv);
    if(*error) return 0;
    return calcWeekdayIdx(&dt,error);
}


SHErrorCode selectChoice(int argc,char *argv[]){
    printf("Hello");
    if(argc < 2){
        printf("No input was given\n");
        return GEN_ERROR;
    }
    if(!strcmp(argv[1],"-h")){
        _printHelpMenu();
        return NO_ERROR;
    }
    printf("past\n");
    choiceHash = calcStrHash(argv[1]) % 33;
    SHErrorCode error = 0;
    if(choiceHash == dt_ts){
        double ans = cl_dtToTimestamp(argc,argv,&error);
        if(error) return error;
        printf("%f\n",ans);
        return NO_ERROR;
    }
    if(choiceHash == ts_dt){
        SHDatetime ans;
        cl_timestampToDt(argc,argv,&error,&ans);
        if(error) return error;
        printf("%lld-%d-%d %d:%d:%d tz offset: %d\n",
          dt.year,dt.month,dt.day,dt.hour,dt.minute,dt.second
          ,dt.timezoneOffset);
        return NO_ERROR;
    }
    if(choiceHash == dtadd){
        SHDatetime ans;
        dtAdd(argc,argv,&error,&ans);
        if(error) return error;
        printf("%lld - %d - %d %d:%d:%d tz offset: %d\n",
          dt.year,dt.month,dt.day,dt.hour,dt.minute,dt.second
          ,dt.timezoneOffset);
        return NO_ERROR;
    }
    if(choiceHash == ddiff){
        long ans = dayDiff(argc,argv,&error);
        if(error) return error;
        printf("%ld\n",ans);
        return NO_ERROR;
    }
    if(choiceHash == weekday){
        int ans = cl_calcWeekdayIdx(argc,argv,&error);
        if(error) return error;
        printf("%d\n",ans);
        return NO_ERROR;
    }
    if(choiceHash == sdiff){
        double ans = secDiff(argc,argv,&error);
        if(error) return error;
        printf("%fn",ans);
        return NO_ERROR;
    }
    return GEN_ERROR;
}


static SHErrorCode _cleanup(){
    if(dt.shiftLen > 0){
        free(dt.shifts);
        dt.shiftLen = 0;
        dt.currentShiftIdx = -1;
    }
    return NO_ERROR;
}

SHErrorCode cl_datetime(int argc,char *argv[]){
    if(argc < 2){
        printf("No input was given\n");
        return GEN_ERROR;
    }
    SHErrorCode error = selectChoice(argc,argv);
    _cleanup();
    if(error){
        printf("Error!\n");
        return error;
    }
    return NO_ERROR;
}
