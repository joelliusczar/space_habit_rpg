//
//  SHQueueStoreItem.h
//  SHModels
//
//  Created by Joel Pridgen on 5/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHQueueStoreItem_h
#define SHQueueStoreItem_h

#include "SHConfigAccessor.h"
#include <stdio.h>
#include <sqlite3.h>

struct SHQueueStoreItem {
	sqlite3 *db;
	struct SHConfigAccessor *config;
};

void SH_freeQueueStoreItem(struct SHQueueStoreItem **item);

#endif /* SHQueueStoreItem_h */