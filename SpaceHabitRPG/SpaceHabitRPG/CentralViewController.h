//
//  CentralViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNavigationController.h"
#import <SHData/CoreDataStackController.h>
#import <SHModels/Daily+CoreDataClass.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/Monster+CoreDataClass.h>

@interface CentralViewController : UIViewController;
@property (weak,nonatomic) IBOutlet UIView *tabsContainer;
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
