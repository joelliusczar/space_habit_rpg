//
//  SHDatetimeCommon.c
//  SHDatetime
//
//  Created by Joel Pridgen on 8/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetimeCommon.h"
#include <stdlib.h>
#include "DTConstants.h"

bool initDt(SHDatetime *dt){
    if(!dt) return false;
    dt->currentShiftIdx = -1;
    dt->day = 1;
    dt->hour = 0;
    dt->minute = 0;
    dt->month = 1;
    dt->second = 0;
    dt->milisecond = 0;
    dt->shiftLen = 0;
    dt->shifts = NULL;
    return true;
}


bool initTimeshift(Timeshift *shift){
    if(!shift) return false;
    shift->adjustment = 0;
    shift->day = 0;
    shift->hour = 0;
    shift->minute = 0;
    shift->month = 0;
    return true;
}
