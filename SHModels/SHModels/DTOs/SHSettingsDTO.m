//
//  SHSettingsDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHSettingsDTO.h"
#import <SHCommon/NSObject+Helper.h>

@implementation SHSettingsDTO


-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  return [self dtoCopy];
}


@end
