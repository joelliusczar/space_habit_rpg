//
//  SHDatetimeProvider.h
//  SHDatetime
//
//  Created by Joel Pridgen on 7/5/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDatetimeProvider_h
#define SHDatetimeProvider_h

#include "SHDatetime_struct.h"

struct SHDatetimeProvider {
	int32_t (*getLocalTzOffset)(void);
	struct SHDatetime *(*getDate)(void);
	struct SHDatetime *(*getUserTodayStart)(void);
};

#endif /* SHDatetimeProvider_h */
