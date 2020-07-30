//
//  SHActivationEvent.h
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHActivationEvent_h
#define SHActivationEvent_h

#include <SHDatetime/SHDatetime.h>
#include <stdio.h>

struct SHActivationEvent {
	int64_t pk;
	int64_t fk;
	struct SHDatetime *eventDatetime;
	int32_t tzOffset;
	int32_t padding;
};

#endif /* SHActivationEvent_h */
