//
//  SHDateTime_struct.h
//  SHCommon
//
//  Created by Joel Pridgen on 4/14/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDateTime_struct_h
#define SHDateTime_struct_h

#include <inttypes.h>

typedef struct{
  int32_t month;
  int32_t day;
  int32_t hour;
  int32_t minute;
  int32_t adjustment;
  uintptr_t filler[8];
}Timeshift;

typedef struct {
  int64_t year;
  int32_t month;
  int32_t day;
  int32_t hour;
  int32_t minute;
  int32_t second;
  int32_t milisecond;
  int32_t timezoneOffset;
  Timeshift *shifts;
  int32_t shiftLen;
  int32_t currentShiftIdx;
  uintptr_t filler[8];
} SHDatetime;

#endif /* SHDateTime_struct_h */
