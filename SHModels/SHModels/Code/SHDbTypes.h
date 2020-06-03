//
//  SHDbTypes.h
//  SHData
//
//  Created by Joel Pridgen on 5/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDbTypes_h
#define SHDbTypes_h
#include <inttypes.h>


typedef enum {
	SH_NULL = 0,
	SH_INT = 1,
	SH_FLOAT = 2,
	SH_BOOL = 3,
	SH_STR = 4
} SHDbTypeNum;

struct SHDbBase;

struct SHDbBase {
	char *name;
	SHDbTypeNum typeNum;
	bool isNull;
	SHDbBase *nextProp;
}


struct SHDbInt {
	struct SHDbBase base;
	int32_t value;
};


struct SHDbFloat {
	struct SHDbBase base;
	double value;
};


struct SHDbStr {
	struct SHDbBase base;
	char *value;
};


struct SHDbBool {
	struct SHDbBase base;
	bool value;
};


#endif /* SHDbTypes_h */
