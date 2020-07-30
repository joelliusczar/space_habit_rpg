//
//  SHTableChangeActions.h
//  SHModels
//
//  Created by Joel Pridgen on 7/28/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHTableChangeActions_h
#define SHTableChangeActions_h

#include <stdio.h>

struct SHTableChangeActions {
	void *owner;
	void (*beginUpdate)(void*);
	void (*endUpdate)(void*);
};

#endif /* SHTableChangeActions_h */
