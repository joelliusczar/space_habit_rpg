//
//  SHModelError.m
//  SHModels
//
//  Created by Joel Pridgen on 4/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHModelError.h"

@implementation SHModelError


-(instancetype)initWithPropertyName:(NSString*)name
  errorDescription:(NSString*)description
  errorLevel:(SHSeverity)level
{
  if(self = [super init]){
    _propertyName = name;
    _errorDesc = description;
    _errorLevel = level;
  }
  return self;
}


+(instancetype)newWithPropertyName:(NSString *)name
  errorDescription:(NSString *)description
  errorLevel:(SHSeverity)level
{
  return [[self alloc] initWithPropertyName:name
    errorDescription:description
    errorLevel:level];
}

@end
