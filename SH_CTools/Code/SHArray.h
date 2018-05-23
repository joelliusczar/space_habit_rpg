//
//  SHArray.h
//  SH_CTools
//
//  Created by Joel Pridgen on 4/19/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//



#include <stdio.h>
#include <stdbool.h>
#include "SHConstants.h"
#include <string.h>

#define DEF_FIND_IDX(T1,T2,P1,P2) static long findIdx_##T1##_##T2( T1 P1 *arr,long len,\
  bool (*test)( T1 P1,long, T2 P2 ), T2 P2 extra){\
    for(long idx = 0; idx < len;idx++){\
      if(test( arr[idx],idx,extra)) return idx;\
    }\
    return NOT_FOUND;\
}
#define findIdx(T1,T2) findIdx_##T1##_##T2

#define DEF_FIND_IDX_REV(T1,T2,P1,P2) static long findIdxRev_##T1##_##T2( T1 P1 *arr\
  ,long len, bool (*test)( T1 P1,long, T2 P2 ), T2 P2 extra){\
    for(long idx = 0; idx < len;idx++){\
      long revIdx = len - idx -1;\
      if(test( arr[revIdx],idx,extra)) return revIdx;\
    }\
    return NOT_FOUND;\
}
#define findIdxRev(T1,T2) findIdxRev_##T1##_##T2

#define DEF_RESIZE_ARR(T) static T * resizeArr_##T##_(T const *src,long olen,long nlen){ \
  T *resized = malloc(nlen*sizeof( T )); \
  memcpy(resized,src,olen*sizeof( T )); \
  return resized; \
}
#define resizeArr(T) resizeArr_##T##_

