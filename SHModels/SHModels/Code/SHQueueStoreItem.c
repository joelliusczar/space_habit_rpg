//
//  SHQueueStoreItem.c
//  SHModels
//
//  Created by Joel Pridgen on 5/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHQueueStoreItem.h"
#include <stdlib.h>


void SH_FreeQueueStoreItem(struct SHQueueStoreItem *item) {
	if(!item) return;
	sqlite3_close(item->db);
	free(item);
}
void SH_FreeQueueStoreItemVoid(void *arg) {
	struct SHQueueStoreItem *item = (struct SHQueueStoreItem *)arg;
	SH_FreeQueueStoreItem(item);
}
