//
//  TestDummy.m
//  TestCommon
//
//  Created by Joel Pridgen on 3/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "TestDummy.h"
#import <SHCommon/SHCommonUtils.h>

@implementation TestDummy

-(TestDummy*)td{
  if(nil == _td){
    _td = [TestDummy new];
  }
  return _td;
}


-(void)justSomething{
  NSLog(@"Something");
}

-(void)methodWithARP{
  dispatch_semaphore_t sema = dispatch_semaphore_create(0);
  TestDummy* td = self.td;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(){
    [td justSomething];
    [NSThread sleepForTimeInterval:500];
    dispatch_semaphore_signal(sema);
  });
  //waitForSema(sema, 2);
}


TestDummy* makeDumb(){
  return [[TestDummy alloc] init];
}

+(instancetype)extraNew{
  return makeDumb();
}

@end
