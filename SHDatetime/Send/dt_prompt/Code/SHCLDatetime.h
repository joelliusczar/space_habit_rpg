

#ifndef SHCLDatetime_h
#define SHCLDatetime_h

#include "SHDatetime_struct.h"
#include "SHErrorHandling.h"
#include <inttypes.h>

SHErrorCode SHCL_dtToTimestamp(int32_t argc,char *argv[], double *ans);
SHErrorCode SHCL_timestampToDt(int32_t argc,char *argv[], struct SHDatetime *dtLocal);
SHErrorCode SHCL_dtAdd(int32_t argc, char *argv[], struct SHDatetime *dtLocal);
SHErrorCode SHCL_dayDiff(int32_t argc,char *argv[],int64_t *ans);
SHErrorCode SHCL_secDiff(int32_t argc, char *argv[], double *ans);
SHErrorCode SHCL_calcWeekdayIdx(int32_t argc,char *argv[],int32_t *ans);
SHErrorCode SHCL_selectChoice(int32_t argc,char *argv[]);
SHErrorCode SHCL_datetimeCalcEntryFn(int32_t argc,char *argv[]);


#endif
