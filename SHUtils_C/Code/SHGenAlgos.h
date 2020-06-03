//
//	SHGenAlgos.h
//	SHUtils_C
//
//	Created by Joel Pridgen on 4/28/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHGenAlgos_h
#define SHGenAlgos_h

#include <stdio.h>
#include <stdint.h>

#if defined(__clang__)
#ifndef blockoptimization
#define blockoptimization __attribute__ ((optnone))
#endif
#elif defined(__GNUC__)
#ifndef blockoptimization
#define blockoptimization __attribute__((optimize("O0")))
#endif
#endif


int64_t SH_calcStrHash(char const *str);
double kahanSum(const double* const nums,int64_t len);
char * shStrCopy(const char * const str);
int32_t SH_bitCount(int64_t num);
#endif /* SHGenAlgos_h */
