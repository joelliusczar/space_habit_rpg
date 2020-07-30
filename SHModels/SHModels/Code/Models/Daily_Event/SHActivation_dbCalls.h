//
//  SHActivation_dbCalls.h
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHActivation_dbCalls_h
#define SHActivation_dbCalls_h

#include "SHDaily_struct.h"
#include "SHActivationEvent.h"
#include <SHUtils_C/SHErrorHandling.h>
#include <SHDatetime/SHDatetime.h>
#include <stdio.h>
#include <sqlite3.h>


SHErrorCode SH_activateDaily(sqlite3 *db, struct SHTableDaily *tableDaily,
	const struct SHDatetimeProvider *dateProvider);
SHErrorCode SH_deactivateDaily(sqlite3 *db, struct SHTableDaily *tableDaily,
	const struct SHDatetimeProvider *dateProvider);

#endif /* SHActivation_dbCalls_h */
