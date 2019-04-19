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
#import <SHModels/SHDaily+CoreDataClass.h>
#import <SHModels/SHSector+CoreDataClass.h>
#import <SHModels/SHMonster+CoreDataClass.h>
#import <SHModels/SHSectorDTO.h>
#import <SHModels/SHHeroDTO.h>
#import <SHModels/SHMonsterDTO.h>
#import <SHModels/SHSettingsDTO.h>

@interface CentralViewController : UIViewController;
@property (weak,nonatomic) IBOutlet UIView *tabsContainer;
@property (strong,nonatomic) id<P_CoreData> dataController;
@property (strong,nonatomic) SHSectorDTO *zoneDTO;
@property (copy,nonatomic) NSManagedObjectID *theDataInfoID;
@property (copy,nonatomic) SHSettingsDTO *settingsDTO;
@property (copy,nonatomic) SHHeroDTO *heroDTO;
@property (copy,nonatomic) SHMonsterDTO *monsterDTO;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;

+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
  andNibName:(NSString*)nib
  andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
  andBundle:(NSBundle*)bundle;

-(instancetype)initWithDataController:(NSObject<P_CoreData>*)dataController
  andNibName:(NSString*)nib
  andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
  andBundle:(NSBundle*)bundle;

-(void)setToShowStory:(BOOL)shouldShowStory;
-(void)afterZonePick:(SHSectorDTO*)zoneChoice withContext:(NSManagedObjectContext*)context;
-(void)afterIntroWithContext:(NSManagedObjectContext*)context;
@end
