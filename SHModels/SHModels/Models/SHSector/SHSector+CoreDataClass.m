//
//  SHSector+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSector+CoreDataClass.h"
#import <SHCommon/SHCommonUtils.h>

@implementation SHSector

-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
//            self.fullName,@"fullName"
//            ,self.sectorKey,@"sectorKey"
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
  shCopyInstanceVar(from, to, @"isFront");
  shCopyInstanceVar(from, to, @"lvl");
  shCopyInstanceVar(from, to, @"maxMonsters");
  shCopyInstanceVar(from, to, @"monstersKilled");
  shCopyInstanceVar(from, to, @"suffix");
  shCopyInstanceVar(from, to, @"uniqueId");
  shCopyInstanceVar(from, to, @"sectorKey");
}

@end
