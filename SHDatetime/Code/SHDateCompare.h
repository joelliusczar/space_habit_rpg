//
//  SHDateCompare.h
//  SHDatetime
//
//  Created by Joel Pridgen on 5/4/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDateCompare_h
#define SHDateCompare_h

#include "SHDatetime_struct.h"
#include "SHErrorHandling.h"
#include <stdio.h>
#include <stdbool.h>

SHErrorCode SH_areDatesEqual(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans);

SHErrorCode SH_isDateAGTDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans);

SHErrorCode SH_isDateAGTEqualDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans);

SHErrorCode SH_isDateALTDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans);

SHErrorCode SH_isDateALTEqualDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans);

#endif /* SHDateCompare_h */
