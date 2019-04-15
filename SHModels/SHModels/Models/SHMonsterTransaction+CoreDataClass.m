//
//  SHMonsterTransaction+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonsterTransaction+CoreDataClass.h"

@implementation SHMonsterTransaction
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


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
  self.lastUpdateTime = [NSDate date];
}


static void copyBetween(NSObject* from,NSObject* to){
  copyInstanceVar(from, to, @"lvl");
  copyInstanceVar(from, to, @"monsterKey");
  copyInstanceVar(from, to, @"nowHp");
}
@end
