//
//  CommonUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//


#import <objc/runtime.h>
#import "CommonUtilities.h"
#import "NSObject+Helper.h"



uint (*randomUInt)(uint) = &arc4random_uniform;

void reverse_UINT(NSUInteger * _Nonnull array,NSUInteger len){
    for(NSUInteger i = 0;i < len/2;i++){
        NSUInteger tmp = array[i];
        array[i] = array[len - i -1];
        array[len -i -1] = tmp;
    }
}

CGFloat getParentChildHeightOffset(CGRect parentFrame,CGRect childFrame){
  return CGRectGetHeight(childFrame) < CGRectGetHeight(parentFrame) ?
      CGRectGetHeight(parentFrame) - CGRectGetHeight(childFrame) : 0;
}


BOOL waitForSema(dispatch_semaphore_t sema,NSInteger timeoutSecs){
  dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * timeoutSecs);
  long result = dispatch_wait(sema,t);
  return result == 0;
}


SEL getSetterSelectorForPropertyName(NSString *propName){
  NSString *firstChar = [[propName substringToIndex:1] uppercaseString];
  NSString *restOfName = [propName substringFromIndex:1];
  NSString *selName = [NSString stringWithFormat:@"set%@%@",firstChar,restOfName];
  return NSSelectorFromString(selName);
}


void copyProp(NSObject *from,NSObject *to,NSString *prop){
  if([from respondsToSelector:getSetterSelectorForPropertyName(prop)] || [from isDictionaryType]){
    if([to respondsToSelector:getSetterSelectorForPropertyName(prop)] || [to isDictionaryType]){
      id newValue = [from valueForKey:prop];
      [from setValue:newValue forKey:prop];
    }
  }
}


void copyInstanceProps(NSObject *from,NSObject *to){
  uint32_t outCount = 0;
  objc_property_t *props = class_copyPropertyList(to.class, &outCount);
  for(uint32_t i = 0; i < outCount;i++){
    const char *propName = property_getName(props[i]);
    NSString *nsPropName = [NSString stringWithUTF8String:propName];
    copyProp(from,to,nsPropName);
    free((void*)propName);
  }
  free(props);
}

