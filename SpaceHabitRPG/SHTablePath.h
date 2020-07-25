//
//  SHTablePath.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHTablePath_h
#define SHTablePath_h

#include <stdio.h>

struct SHTablePath {
	void *owner;
	uint64_t sectionIdx;
	uint64_t rowIdx;
};

#endif /* SHTablePath_h */
