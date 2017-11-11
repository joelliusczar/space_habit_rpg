//
//  CentralViewControllerP.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditNavigationController.h"
#import "P_CoreData.h"
#import "Daily+CoreDataClass.h"
#import "Zone+CoreDataClass.h"
#import "Monster+CoreDataClass.h"

@protocol CentralViewControllerP <NSObject>
@property (strong,nonatomic) id<P_CoreData> dataController;
@property (readonly,nonatomic) Settings *userSettings;
@property (readonly,nonatomic) Hero *userHero;
@property (strong,nonatomic) Zone *nowZone;
@property (strong,nonatomic) Monster *nowMonster;
-(void)setToShowStory:(BOOL)shouldShowStory;
-(void)showZoneChoiceView;
-(void)afterZonePick:(Zone *)zoneChoice;
-(void)afterIntro;
@end
