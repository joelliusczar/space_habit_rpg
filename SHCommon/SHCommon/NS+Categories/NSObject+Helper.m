//
//  NSObject+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSObject+Helper.h"
#import "SHCommonUtils.h"
#import <objc/runtime.h>


typedef void (*voidCaller)(id,SEL);

@implementation NSObject (Helper)


-(void)safeRemoveObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nonnull)keyPath context:(void *_Nullable)context{
    @try{
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
    @catch(NSException *ex){}
}


-(BOOL)isDictionaryType{
  //if enough classes are added here, it may be better to set up a set somewhere
  if([self isKindOfClass:NSDictionary.class]){
    return YES;
  }
  return NO;
}


-(id)dtoCopy{
  id newObject = [[self.class alloc] init];
  uint32_t outCount = 0;
  Ivar *varArray = class_copyIvarList(self.class, &outCount);
  for(uint32_t i = 0; i < outCount; i++){
    const char *varName = ivar_getName(varArray[i]);
    NSString *nsVarName = [NSString stringWithUTF8String:varName];
    id varVal = [self valueForKey:nsVarName];
    [newObject setValue:varVal forKey:nsVarName];
  }
  free(varArray);
  return newObject;
}


-(void)dtoCopyFrom:(NSObject*)fromObject{
  uint32_t outCount = 0;
  Ivar *varArray = class_copyIvarList(self.class, &outCount);
  for(uint32_t i = 0; i < outCount; i++){
    const char *ivarName = ivar_getName(varArray[i]);
    NSString *nsIvarName = [NSString stringWithUTF8String:ivarName];
    NSString *propName = [nsIvarName substringFromIndex:1];
    id fromVal = [fromObject valueForKey:propName];
    [self setValue:fromVal forKey:nsIvarName];
  }
  free(varArray);
}

//the reason I have this here rather than for UIView is because
//of the possibility that I need to use it a custom viewController class
//which would not inherit from UIView
#if IS_IOS
-(UIView *)loadXib:(NSString *)nibName{
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    @try {
      NSArray *nibs = [bundle loadNibNamed:nibName owner:self options:nil];
      if(nibs.count > 0) {
        return [bundle loadNibNamed:nibName owner:self options:nil][0];
      }
    return nil;
    }
    @catch (NSException *exception) {
      return nil;
    }
  
}
#endif

/*
  this is not technically being used, but I need it
  to make respondToSelector work for implementations
  elsewhere.
*/
-(BOOL)shouldIgnoreProperty:(NSString *)propName{
  return NO;
}

@end
