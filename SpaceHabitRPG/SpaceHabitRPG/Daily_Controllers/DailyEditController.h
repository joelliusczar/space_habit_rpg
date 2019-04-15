//
//  DailyEditController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyViewController.h"
#import "EditingSaver.h"
#import <SHData/P_CoreData.h>
#import <SHGlobal/Constants.h>
#import <SHModels/Daily+CoreDataClass.h>
#import <SHModels/SHDailyDTO.h>
#import <SHControls/P_DailyEditCompound.h>
#import <SHControls/AllSHControls.h>


@interface DailyEditController : UIViewController
<EditingSaver
,P_DailyEditCompound
,UITableViewDataSource
,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet SHTextField *nameBox;
@property (weak,nonatomic) IBOutlet SHButton *showXtraOptsBtn;
@property (weak,nonatomic) IBOutlet UITableView *controlsTbl;
@property (strong,nonatomic) Daily *modelForEditing;
@property (weak,nonatomic) DailyViewController *parentDailyController;

-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController;

-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController
ToEdit:(Daily *)daily
AtIndexPath:(NSIndexPath *)rowInfo;

-(void)loadExistingDailyForEditing:(Daily *)daily;
@end

#import "DailyEditController+ControlLoaders.h"
