//
//  CentralViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNavigationController.h"
#import <SHData/SHCoreData.h>
#import <SHModels/Daily+CoreDataClass.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/Monster+CoreDataClass.h>
#import <SHModels/SHZoneDTO.h>
#import <SHModels/SHHeroDTO.h>
#import <SHModels/SHMonsterDTO.h>
#import <SHModels/SHSettingsDTO.h>

@interface CentralViewController : UIViewController;
@property (weak,nonatomic) IBOutlet UIView *tabsContainer;
@property (strong,nonatomic) id<P_CoreData> dataController;
@property (strong,nonatomic) ZoneDTO *zoneDTO;
@property (copy,nonatomic) NSManagedObjectID *theDataInfoID;
@property (copy,nonatomic) SHSettingsDTO *settingsDTO;
@property (copy,nonatomic) HeroDTO *heroDTO;
@property (copy,nonatomic) MonsterDTO *monsterDTO;
@property (strong,nonatomic) NSObject<P_ResourceUtility> *resourceUtil;

+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
  andNibName:(NSString*)nib
  andResourceUtil:(NSObject<P_ResourceUtility>*)util
  andBundle:(NSBundle*)bundle;

-(void)setToShowStory:(BOOL)shouldShowStory;
-(void)afterZonePick:(ZoneDTO*)zoneChoice withContext:(NSManagedObjectContext*)context;
-(void)afterIntroWithContext:(NSManagedObjectContext*)context;
@end
