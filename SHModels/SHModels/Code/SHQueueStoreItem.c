//
//  SHQueueStoreItem.c
//  SHModels
//
//  Created by Joel Pridgen on 5/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHQueueStoreItem.h"
#include <stdlib.h>


void SH_freeQueueStoreItem(struct SHQueueStoreItem **itemP2) {
	if(!itemP2) return;
	struct SHQueueStoreItem *item = *itemP2;
	if(!item) return;
	sqlite3_close(item->db);
	free(item);
	*itemP2 = NULL;
}
