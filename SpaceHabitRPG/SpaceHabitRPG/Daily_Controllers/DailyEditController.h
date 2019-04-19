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
#import <SHData/SHCoreDataProtocol.h>
#import <SHGlobal/SHConstants.h>
#import <SHModels/SHDaily+CoreDataClass.h>
#import <SHModels/SHDailyDTO.h>
#import <SHControls/SHDailyEditCompoundProtocol.h>
#import <SHControls/AllSHControls.h>


@interface DailyEditController : UIViewController
<EditingSaver
,SHDailyEditCompoundProtocol
,UITableViewDataSource
,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet SHTextField *nameBox;
@property (weak,nonatomic) IBOutlet SHButton *showXtraOptsBtn;
@property (weak,nonatomic) IBOutlet UITableView *controlsTbl;
@property (strong,nonatomic) SHDaily *modelForEditing;
@property (weak,nonatomic) DailyViewController *parentDailyController;

-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController;

-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController
ToEdit:(SHDaily *)daily
AtIndexPath:(NSIndexPath *)rowInfo;

-(void)loadExistingDailyForEditing:(SHDaily *)daily;
@end

#import "DailyEditController+ControlLoaders.h"
