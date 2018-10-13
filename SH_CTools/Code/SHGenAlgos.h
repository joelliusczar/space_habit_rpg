//
//  SHGenAlgos.h
//  SH_CTools
//
//  Created by Joel Pridgen on 4/28/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHGenAlgos_h
#define SHGenAlgos_h

#if defined(__clang__)
#ifndef blockoptimization
#define blockoptimization __attribute__ ((optnone))
#endif
#elif defined(__GNUC__)
#ifndef blockoptimization
#define blockoptimization __attribute__((optimize("O0")))
#endif
#endif 

#include <stdio.h>
#include <inttypes.h>
int64_t calcStrHash(char const *str);
double kahanSum(const double* const nums,int64_t len);
#endif /* SHGenAlgos_h */
