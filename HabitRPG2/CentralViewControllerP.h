//
//  CentralViewControllerP.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditNavigationController.h"
#import "CoreDataStackController.h"
#import "Daily+CoreDataClass.h"
#import "Zone+CoreDataClass.h"
#import "Monster+CoreDataClass.h"

@protocol CentralViewControllerP <NSObject>
@property (nonatomic,strong) CoreDataStackController *dataController;
@property (nonatomic,strong) EditNavigationController *editController;
@property (nonatomic,weak) Settings *userSettings;
@property (nonatomic,weak) Hero *userHero;
@property (nonatomic,strong) Zone *nowZone;
@property (nonatomic,strong) Monster *nowMonster;
-(void)setToSkipStory:(BOOL)skipStory;
-(void)showZoneChoiceView;
-(void)setupNormal;
@end
