//
//  NSManagedObjectContext+Hijack.m
//  TestCommon
//
//  Created by Joel Pridgen on 3/21/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <objc/runtime.h>
#import "TestHelpers.h"
#import "NSManagedObjectContext+Hijack.h"

@implementation NSManagedObjectContext (Hijack)

#define HIJACK_CONTEXT_RELEASE 1

#ifdef HIJACK_CONTEXT_RELEASE

+(void)load{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken,^{
    SEL sel0 = NSSelectorFromString(@"_registerAsyncReferenceCallback");
    SEL sel1 = @selector(intercept_refCallback);
  
    Class contextClass = NSManagedObjectContext.class;
    [self hijack:contextClass originalSelector:sel0 replacementSelector:sel1];
    //_registerAsyncReferenceCallback
    
    SEL sel2 = NSSelectorFromString(@"release");
    SEL sel3 = @selector(intercepted_release);
    [self hijack:contextClass originalSelector:sel2 replacementSelector:sel3];
    
    SEL seldealloc0 = NSSelectorFromString(@"dealloc");
    SEL seldealloc1 = @selector(dealloc_intercept);
    [self hijack:contextClass originalSelector:seldealloc0 replacementSelector:seldealloc1];

  });
}

+(void)hijack:(Class)contextClass originalSelector:(SEL)sel0 replacementSelector:(SEL)sel1{
  
  
    Method m0 = class_getInstanceMethod(contextClass, sel0);
    IMP imp0 = method_getImplementation(m0);
    const char* enc0 = method_getTypeEncoding(m0);
  
    Method m1 = class_getInstanceMethod(contextClass, sel1);
    IMP imp1 = method_getImplementation(m1);
    const char* enc1 = method_getTypeEncoding(m1);
  
    BOOL didAddMethod = class_addMethod(contextClass,sel0,imp1,enc1);
  
    if(didAddMethod){
      class_replaceMethod(contextClass, sel1, imp0, enc0);
    }
    else{
      method_exchangeImplementations(m0,m1);
    }
}


-(void)intercepted_release{
  NSLog(@"Releasing");
  [self intercepted_release];
}


-(void)intercept_refCallback{
  NSLog(@"async callback shit");
  [self intercept_refCallback];
}


-(void)dealloc_intercept{
  NSLog(@"deallocating this mofo");
  [self dealloc_intercept];
}
#endif

@end
