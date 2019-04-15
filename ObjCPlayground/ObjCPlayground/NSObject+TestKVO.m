//
//  NSObject+TestKVO.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSObject+TestKVO.h"

@implementation NSObject (TestKVO)



-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  NSLog(@"Wrong key, dog!");
}

@end
