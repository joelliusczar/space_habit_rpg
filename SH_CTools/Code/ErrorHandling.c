//
//  ErrorHandling.c
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "ErrorHandling.h"
const int NULL_VALUES = 1;
const int OUT_OF_RANGE = NULL_VALUES + 1;
const int CORRUPT_STRUCT = OUT_OF_RANGE + 1;

bool setErrorCode(int code,int *error){
    *error = code;
    return false;
}
