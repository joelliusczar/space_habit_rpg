//
//  NoArcExp.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/11/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FromCFunc.h"
#import "ArcLessObj.h"

typedef struct{
  int firstItem;
  int secondItem;
  int thirdItem;
} dumbStruct;

@interface NoArcExp : NSObject
+(void)objectToCharPtr;
+(void)retainShit;
+(void)allocStruct;
@end
