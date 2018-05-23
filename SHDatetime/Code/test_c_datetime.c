#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "SHDatetime_struct.h"
#include "SHDatetime.h"

typedef struct {
    int month;
    int day;
} MonthDay;

static MonthDay _dts[1461]; 

int _fillMonth(int start,int month,int days){
    int i;
    for(i = 0;i < days;i++){
        _dts[i+start] = (MonthDay){month,(i+1)};
    }
    return start + i;
}

int _fillYear(int sumIdx,int isLeapYear){
    sumIdx = _fillMonth(sumIdx,1,31);
    sumIdx = _fillMonth(sumIdx,2,28 + (isLeapYear?1:0));
    sumIdx = _fillMonth(sumIdx,3,31);
    sumIdx = _fillMonth(sumIdx,4,30);
    sumIdx = _fillMonth(sumIdx,5,31);
    sumIdx = _fillMonth(sumIdx,6,30);
    sumIdx = _fillMonth(sumIdx,7,31);
    sumIdx = _fillMonth(sumIdx,8,31);
    sumIdx = _fillMonth(sumIdx,9,30);
    sumIdx = _fillMonth(sumIdx,10,31);
    sumIdx = _fillMonth(sumIdx,11,30);
    sumIdx = _fillMonth(sumIdx,12,31);
    return sumIdx;
}

void _fillAll(){
    int sumIdx = 0;
    sumIdx = _fillYear(sumIdx,1);
    sumIdx = _fillYear(sumIdx,0);
    sumIdx = _fillYear(sumIdx,0);
    sumIdx = _fillYear(sumIdx,0);
}

int testCTimeExhaustive(long lowBound, long upBound){
    int isEnd = 0;
    SHDateTime dt;
    long ans = -1;
    long dayIdx = 0;
    int error;
    for(long i=lowBound;!isEnd;i++){
        if(i == upBound) isEnd = 1;
        tryTimestampToDt(i,0,&dt,&error);
        if(error){
            printf("\ntimestamp to dt ended with error code %d\n",error);
            return -1;
        }
        tryDtToTimestamp(&dt,&ans,&error);
        if(error){
            printf("\ndt to timestamp ended with error code %d\n",error);
            return -1;
        }
        if(i % 86400 == 0){
            int month0 = _dts[dayIdx %1461].month;
            int day0 = _dts[dayIdx%1461].day;
            if(month0!= dt.month || day0 != dt.day){
                printf("\nactual month:%d actual day:%d_\n",dt.month,dt.day);
                printf("\nexpected month:%d expected day:%d_\n",
                    month0,day0);
                return -1;
            }
            dayIdx++;

            printf("\ryear %ld month:%d day:%d_",dt.year,dt.month,dt.day);
            fflush(0);
        }
        if(ans != i){
            printf("\nExpected value: %ld actual value: %ld\n",i,ans);
            return -1;    
        }
    }
    return 0;
}

int main(int argc,char *argv[]){
    long lowBound = YEAR_ZERO_FIRST_SEC;
    long upBound = LONG_MAX;
    if(argc == 2){
        char *ptr;
        lowBound = strtol(argv[1],&ptr,10);
    }
    else if(argc == 3){
        char *ptr;
        lowBound = strtol(argv[1],&ptr,10);
        upBound = strtol(argv[2],&ptr,10);
    }
    _fillAll();
    return testCTimeExhaustive(lowBound,upBound);
}
