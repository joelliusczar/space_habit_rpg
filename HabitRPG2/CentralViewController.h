//
//  CentralViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNavigationController.h"
#import "CoreDataStackController.h"
#import "Daily+CoreDataClass.h"
#import "Zone+CoreDataClass.h"
#import "Monster+CoreDataClass.h"

@interface CentralViewController : UIViewController
@property (nonatomic,strong) CoreDataStackController *dataController;
@property (nonatomic,strong) EditNavigationController *editController;
@property (nonatomic,weak) Settings *userSettings;
@property (nonatomic,weak) Hero *userHero;
@property (nonatomic,strong) Zone *nowZone;
@property (nonatomic,strong) Monster *nowMonsters;
-(void)doActionForCompletedDaily:(Daily *)daily;
-(void)undoActionForCompletedDaily:(Daily *)daily;
-(void)setToSkipStory:(BOOL)skipStory;
-(void)showZoneChoiceView;
-(void)afterIntro:(Zone *)firstZone;
@end
