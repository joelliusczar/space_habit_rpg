//
//  SHGenAlgos.c
//  SH_CTools
//
//  Created by Joel Pridgen on 4/28/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHGenAlgos.h"

long calcStrHash(char const *str){
    long hash = 7;
    int idx = 0;
    int prime = 31;
    while(str[idx] != '\0'){
        hash += hash*prime + str[idx++];
    }
    return hash;
}
