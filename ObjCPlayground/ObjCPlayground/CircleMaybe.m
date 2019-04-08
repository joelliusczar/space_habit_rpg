//
//  CircleMaybe.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "CircleMaybe.h"

@interface CircleMaybe ()
@property (nonatomic) dispatch_queue_t q;
@property (strong,nonatomic) NSObject *secretFoo;
@property (assign,nonatomic) NSInteger boot;
@property (copy,nonatomic) void (^myBlock)(void);
@end

@implementation CircleMaybe


-(NSObject*)foo{
  __block id result = nil;
  dispatch_sync(self.q,^{
    result = [self secretFoo];
  });
  return result;
}

-(void)setFoo:(NSObject *)foo{
  dispatch_async(self.q,^{
    self.secretFoo = foo;
  });
}

@synthesize bar = _bar;
-(NSInteger)bar{
  __block NSInteger result = 0;
  dispatch_sync(self.q,^{
    result = self->_bar;
  });
  return result;
}


-(void)setBar:(NSInteger)bar{
  dispatch_async(self.q,^{
    self->_bar = bar;
  });
}

-(instancetype)init{
  if(self = [super init]){
    _q = dispatch_queue_create("My_que", DISPATCH_QUEUE_SERIAL);
    _boot = 17;
  }
  return self;
}


-(void)makeNoise{
  NSLog(@"Hello from CircleMaybe");
}


-(void)dropSelfInQ{
  dispatch_async(self.q,^{
    [NSThread sleepForTimeInterval:5];
    [self makeNoise];
    NSLog(@"%lu",self.boot);
    
  });
}

-(void)addBlock{
  self.myBlock = ^{
    [self makeNoise];
  };
}


-(void)dealloc{
  NSLog(@"Deallocating this cunt!");
}

@end
