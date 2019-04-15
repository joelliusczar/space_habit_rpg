//
//  SHSector+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSector+CoreDataClass.h"

@implementation SHSector

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


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
}


static void copyBetween(NSObject* from,NSObject* to){
  copyInstanceVar(from, to, @"isFront");
  copyInstanceVar(from, to, @"lvl");
  copyInstanceVar(from, to, @"maxMonsters");
  copyInstanceVar(from, to, @"monstersKilled");
  copyInstanceVar(from, to, @"suffix");
  copyInstanceVar(from, to, @"uniqueId");
  copyInstanceVar(from, to, @"zoneKey");
}

@end
