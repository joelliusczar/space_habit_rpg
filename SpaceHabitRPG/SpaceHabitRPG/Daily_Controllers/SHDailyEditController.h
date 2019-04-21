//
//  SHDailyEditController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHDailyViewController.h"
#import "SHEditingSaverProtocol.h"
#import <SHData/SHCoreDataProtocol.h>
#import <SHGlobal/SHConstants.h>
#import <SHModels/SHDaily.h>
#import <SHModels/SHDailyDTO.h>
#import <SHControls/SHDailyEditCompoundProtocol.h>
#import <SHControls/AllSHControls.h>


@interface SHDailyEditController : UIViewController
<SHEditingSaverProtocol
,SHDailyEditCompoundProtocol
,UITableViewDataSource
,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet SHTextField *nameBox;
@property (weak,nonatomic) IBOutlet SHButton *showXtraOptsBtn;
@property (weak,nonatomic) IBOutlet UITableView *controlsTbl;
@property (strong,nonatomic) SHDaily *modelForEditing;
@property (weak,nonatomic) SHDailyViewController *parentDailyController;

-(instancetype)initWithParentDailyController:(SHDailyViewController *)parentDailyController;

-(instancetype)initWithParentDailyController:(SHDailyViewController *)parentDailyController
ToEdit:(SHDaily *)daily
AtIndexPath:(NSIndexPath *)rowInfo;

-(void)loadExistingDailyForEditing:(SHDaily *)daily;
@end

#import "SHDailyEditController+ControlLoaders.h"
