//
//  ErrorHandling.c
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "ErrorHandling.h"
#include "SHConstants.h"
const int NULL_VALUES = 1;
const int OUT_OF_RANGE = 2;
const int CORRUPT_STRUCT = 3;

bool setErrorCode(int code,int *error){
    *error = code;
    return false;
}


int setIndexErrorCode(int code,int *error){
    *error = code;
    return NOT_FOUND;
}
