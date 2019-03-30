//
//  SHDatetimePtrExt.c
//  SHDatetime
//
//  Created by Joel Pridgen on 8/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetimePtrExt.h"
#include "SHDatetimeMod.h"
#include <stdlib.h>



SHDatetime* shTimestampToDt(double timestamp,int timezoneOffset,SHError *error){
  SHDatetime* dt = malloc(sizeof(SHDatetime));
  shTryTimestampToDt_m(timestamp,timezoneOffset,dt,error);
  return dt;
}
