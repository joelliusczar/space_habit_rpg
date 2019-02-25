//
//  TestHelpers.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TestHelpers.h"

@implementation TestHelpers

+(void)resetCoreData:(NSManagedObjectContext *)context{
    NSPersistentStore *ps = context.persistentStoreCoordinator.persistentStores[0];
    NSError *err;
    [context.persistentStoreCoordinator removePersistentStore:ps error:&err];
}


+(void*)getPrivateValue:(id<NSObject>)obj ivarName:(NSString *)ivarName{
  Ivar ivar = class_getInstanceVariable(obj.class,[ivarName UTF8String]);
  return (__bridge void *)(object_getIvar(obj,ivar));
}


+(void)setPrivateVar:(id<NSObject>)obj ivarName:(NSString *)ivarName
newVal:(id)newVal{
  Ivar ivar = class_getInstanceVariable(obj.class,[ivarName UTF8String]);
  object_setIvar(obj, ivar, newVal);
}


+(void)forceRelease:(id)obj{
  msg_send fRelease = (msg_send)objc_msgSend;
  SEL rel = NSSelectorFromString(@"release");
  fRelease(obj,rel);
}


+(NSArray<NSString*>*)getMethodList:(id)obj{
  uint32_t outCount = 0;
  Method* m = class_copyMethodList([obj class],&outCount);
  NSMutableArray* results = [NSMutableArray array];
  for(int i = 0; i < outCount;i++){
     [results addObject: NSStringFromSelector(method_getName(*m))];
     m++;
  }
  return [NSArray arrayWithArray:results];
}


@end
