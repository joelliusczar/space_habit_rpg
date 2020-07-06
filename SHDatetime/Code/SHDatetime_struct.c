//
//  SHDatetime_struct.c
//  SHDatetime
//
//  Created by Joel Pridgen on 7/5/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDatetime_struct.h"
#include <stdlib.h>


void SH_freeSHTimeshift(struct SHTimeshift **tsObjP2){
	if(!tsObjP2) return;
	struct SHTimeshift *tsObj = *tsObjP2;
	if(!tsObj) return;
	free(tsObj);
	*tsObjP2 = NULL;
}


void SH_freeSHDatetime(struct SHDatetime **dtObjP2){
	if(!dtObjP2) return;
	struct SHDatetime *dtObj = *dtObjP2;
	if(!dtObj) return;
	SH_freeSHTimeshift(&dtObj->shifts);
	free(dtObj);
	*dtObjP2 = NULL;
}
