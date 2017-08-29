//
//  DailyEditResponder.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_DailyEditCompound.h"
#import "Daily+CoreDataClass.h"
#import "DailyEditControlKeep.h"

@class DailyEditControlKeep;

@interface DailyEditResponder : NSObject<P_DailyEditCompound>
@property (strong,nonatomic) Daily *daily;
@property (strong,nonatomic) DailyEditControlKeep *editControls;
@property (assign,nonatomic) BOOL isDirty;
-(instancetype)initWith:(Daily *)daily;
@end
