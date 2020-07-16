//
//  SHFetchTableItemsArgs.h
//  SHModels
//
//  Created by Joel Pridgen on 7/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHFetchTableItemsArgs_h
#define SHFetchTableItemsArgs_h

#include <SHUtils_C/SHSerialAccessCollection.h>
#include <SHDatetime/SHDatetime.h>
#include <stdio.h>

struct SHFetchTableItemsArgs {
	struct SHSerialAccessCollection *saCollection;
	struct SHDatetimeProvider *dateProvider;
};


#endif /* SHFetchTableItemsArgs_h */
