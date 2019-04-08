//
//  Zone+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataClass.h"
#import "ZoneInfoDictionary.h"
#import <SHCommon/SingletonCluster.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import <SHCommon/CommonUtilities.h>

@interface Zone()
@end

@implementation Zone


-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
//            self.fullName,@"fullName"
//            ,self.zoneKey,@"zoneKey"
//            ,self.suffix,@"suffix"
            [NSNumber numberWithInt:self.lvl],@"lvl"
            ,[NSNumber numberWithInt:self.maxMonsters],@"maxMonsters"
            ,[NSNumber numberWithInt:self.monstersKilled],@"monstersKilled"
            ,[NSNumber numberWithLong:self.uniqueId],@"uniqueId"
            ,[NSNumber numberWithBool:self.isFront],@"isFront", nil];
}


-(void)copyInto:(NSObject*)object{
  copyProp(self, object, @"objectID");
  copyBetween(self, object);
}


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
}


static void copyBetween(NSObject* from,NSObject* to){
  copyProp(from, to, @"isFront");
  copyProp(from, to, @"lvl");
  copyProp(from, to, @"maxMonsters");
  copyProp(from, to, @"monstersKilled");
  copyProp(from, to, @"suffix");
  copyProp(from, to, @"uniqueId");
  copyProp(from, to, @"zoneKey");
}

@end
