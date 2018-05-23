//
//  ErrorHandling.h
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef ErrorHandling_h
#define ErrorHandling_h

#include <stdio.h>
#include <stdbool.h>

extern const int NULL_VALUES;
extern const int OUT_OF_RANGE;
extern const int CORRUPT_STRUCT;



bool setErrorCode(int code,int *error);
int setIndexErrorCode(int code,int *error);
#endif /* ErrorHandling_h */
