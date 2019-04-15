//
//  SimpleDTO.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SimpleDTO.h"
//#import "NSObject+TestKVO.h"

@implementation SimpleDTO{
  NSNumber *_watched;
}

-(instancetype)init{
  if(self = [super init]){
  }
  return self;
}

-(NSNumber*)watched{
  if(nil == self->_watched){
    _watched = @71;
  }
  return _watched;
}


+(BOOL)accessInstanceVariablesDirectly{
  return NO;
}


-(void)sayRealSlimShady{
  NSLog(@"I'm the real slim shady");
}

@end

