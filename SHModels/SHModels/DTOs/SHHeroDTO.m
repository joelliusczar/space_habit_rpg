//
//  SHHeroDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHeroDTO.h"
#import <SHCommon/CommonUtilities.h>

@implementation HeroDTO


+(instancetype)newWithObjectID:(NSManagedObjectID*)objectID withContext:(NSManagedObjectContext*)context{
  HeroDTO *instance = [HeroDTO new];
  return instance;
}

-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  HeroDTO *hero = [HeroDTO new];
  copyInstanceProps(self,hero);
  return hero;
}
@end
