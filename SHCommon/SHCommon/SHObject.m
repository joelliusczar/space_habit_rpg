//
//  SHObject.m
//  SHCommon
//
//  Created by Joel Pridgen on 4/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHObject.h"

@implementation SHObject

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  (void)value;
  (void)key;
}


-(id)valueForUndefinedKey:(NSString *)key{
  (void)key;
  return nil;
}

@end
