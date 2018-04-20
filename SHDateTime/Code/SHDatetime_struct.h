//
//  SHDateTime_struct.h
//  SHCommon
//
//  Created by Joel Pridgen on 4/14/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDateTime_struct_h
#define SHDateTime_struct_h


typedef struct{
    int month;
    int day;
    int hour;
    int minute;
    int adjustment;
}TimeShift;

typedef struct {
    long year;
    int month;
    int day;
    int hour;
    int minute;
    int second;
    int timezoneOffset;
    TimeShift *shifts;
    int shiftLen;
    int currentShiftIdx;
} SHDateTime;

#endif /* SHDateTime_struct_h */
