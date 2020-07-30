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

SHErrorCode SH_areDatesEqual(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans);

SHErrorCode SH_isDateXAfterDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans);

SHErrorCode SH_isDateXAfterOrSameAsDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans);

SHErrorCode SH_isDateXBeforeDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans);

SHErrorCode SH_isDateXBeforeOrSameAsDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans);

#endif /* SHDateCompare_h */
