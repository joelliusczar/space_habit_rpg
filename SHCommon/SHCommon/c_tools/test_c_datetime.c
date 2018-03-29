#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "c_datetime.h"


int testCTimeExhaustive(long lowBound, long upBound){
    int isEnd = 0;
    SHDateTime dt;
    long ans = -1;
    for(long i=lowBound;!isEnd;i++){
        if(i == upBound) isEnd = 1;
        timestampToDateObj(i,0,&dt);
        dateObjToTimestamp(&dt,&ans);
        if(i % 86400 == 0){
            printf("\ryear %ld month:%d day:%d_______",dt.year,dt.month,dt.day);
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
    return testCTimeExhaustive(lowBound,upBound);
}