//
//  SHDatetime_struct.c
//  SHDatetime
//
//  Created by Joel Pridgen on 7/5/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDatetime_struct.h"
#include <stdlib.h>


void SH_freeSHTimeshift(struct SHTimeshift *tsObj){
	free(tsObj);
}


void SH_freeSHDatetime(struct SHDatetime *dtObj){
	if(!dtObj) return;
	SH_freeSHTimeshift(dtObj->shifts);
	free(dtObj);
}
