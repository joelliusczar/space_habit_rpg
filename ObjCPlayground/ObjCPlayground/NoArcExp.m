//
//  NoArcExp.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/11/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "NoArcExp.h"
#import "House.h"

@implementation NoArcExp

+(void)objectToCharPtr{
    House *h = [[House alloc] init];
    char *c = (char *)h;
    (void)c;
}

+(ArcLessObj*)doNilMaybe{
  ArcLessObj* obj = [[ArcLessObj alloc] init];
  return obj;
}

+(void)doesItStickAround{
  ArcLessObj* obj = [[ArcLessObj alloc] init];
  obj.nombre = @"sticks around";
  NSLog(@"%@",obj);
}

+(void)shouldNotStick{
  ArcLessObj* obj = [[ArcLessObj alloc] init];
  NSLog(@"%@",obj);
  [obj release];
}

+(ArcLessObj*)overReleased{
  ArcLessObj* obj = [[ArcLessObj alloc] init];
  obj.nombre = @"todah!";
  NSLog(@"%@",obj);
  [obj release];
  return obj;
}

+(void)autoReleaseInside{
  ArcLessObj* obj = [[[ArcLessObj alloc] init] autorelease];
  obj.nombre = @"insido";
  NSLog(@"%@",obj);
}

+(void)retainShit{
  ArcLessObj* __unsafe_unretained weakMaybe = nil; //__unsafe_unretained does nothing here
  [self shouldNotStick];
  ArcLessObj* probsNil = [self overReleased];
  NSLog(@"%@",probsNil);
  //NSLog(@"%@",probsNil.nombre);
  //[probsNil doATrick];
  [self autoReleaseInside];
  @autoreleasepool {
    ArcLessObj* maybeNil = [self doNilMaybe];
    weakMaybe = maybeNil;
    NSLog(@"%@",weakMaybe);
    [self autoReleaseInside];
  }
  NSLog(@"%@",weakMaybe);
  [self doesItStickAround];
}


+(void)allocStruct{
  dumbStruct* ds = malloc(sizeof(dumbStruct));
  ds->firstItem = 17;
  ds->secondItem = 34;
  free(ds);
}

@end
