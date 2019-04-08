//
//  Monster+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"
#import <SHCommon/CommonUtilities.h>

@interface Monster()
@end

@implementation Monster


-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.monsterKey,@"monsterKey"
            ,[NSNumber numberWithInt:self.lvl],@"lvl"
//            ,[NSNumber numberWithInt:self.nowHp],@"nowHp"
//            ,[NSNumber numberWithInt:self.attack],@"attack"
//            ,[NSNumber numberWithInt:self.defense],@"defense"
//            ,[NSNumber numberWithInt:self.maxHp],@"maxHp"
            , nil];
}


-(void)copyInto:(NSObject*)object{
  copyProp(self, object, @"objectID");
  copyBetween(self, object);
}


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
  self.lastUpdateTime = [NSDate date];
}


static void copyBetween(NSObject* from,NSObject* to){
  copyProp(from, to, @"lvl");
  copyProp(from, to, @"monsterKey");
  copyProp(from, to, @"nowHp");
}

@end
