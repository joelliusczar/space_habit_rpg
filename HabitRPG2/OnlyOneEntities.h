//
//  OnlyOneEntities.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataInfo+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "Hero+CoreDataClass.h"
#import "P_CoreData.h"
@protocol P_CoreData;

@interface OnlyOneEntities : NSObject
@property (nonatomic,strong) DataInfo *theDataInfo;
@property (nonatomic,strong) Settings *theSettings;
@property (nonatomic,strong) Hero *theHero;
-(instancetype)initWithDataController:(NSObject<P_CoreData> *)dataController;
@end
