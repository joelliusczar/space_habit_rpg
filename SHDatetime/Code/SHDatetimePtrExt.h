//
//  SHDatetimePtrExt.h
//  SHDatetime
//
//  Created by Joel Pridgen on 8/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDatetimePtrExt_h
#define SHDatetimePtrExt_h

#include <stdio.h>
#include "SHDatetime_struct.h"
#include "SHErrorHandling.h"

SHDatetime* shTimestampToDt(double timestamp,int timezoneOffset,SHError *error);

#endif /* SHDatetimePtrExt_h */
