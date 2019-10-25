//
//	NoArcExp.h
//	ObjCPlayground
//
//	Created by Joel Pridgen on 3/11/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

@import Foundation;
#import "FromCFunc.h"
#import "ArcLessObj.h"
#import "QNoArc.h"

typedef struct{
	int firstItem;
	int secondItem;
	int thirdItem;
	void *tstPtr;
} dumbStruct;

@interface NoArcExp : NSObject
+(void)objectToCharPtr;
+(void)retainShit;
+(void)allocStruct;
+(void)overRelease;
+(void)playWithQueues;
+(void)underRelease;
@end
