//
//  SHMonster+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonster+CoreDataClass.h"
#import <SHCommon/SHCommonUtils.h>

@implementation SHMonster


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
  self.lastUpdateDateTime = [NSDate date];
}


static void copyBetween(NSObject* from,NSObject* to){
  shCopyInstanceVar(from, to, @"lvl");
  shCopyInstanceVar(from, to, @"monsterKey");
  shCopyInstanceVar(from, to, @"nowHp");
}


@end
