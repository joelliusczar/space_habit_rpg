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
#import "P_CoreData.h"
#import "constants.h"
#import "Daily+CoreDataClass.h"
#import "P_DailyEditCompound.h"


@interface DailyEditController : UIViewController
<EditingSaver
,UITableViewDataSource
,UITableViewDelegate
,P_DailyEditCompound>
@property (weak,nonatomic) IBOutlet UITextField *nameBox;
@property (weak,nonatomic) IBOutlet UIButton *showXtraOptsBtn;
@property (weak,nonatomic) IBOutlet UITableView *controlsTbl;
@property (strong,nonatomic) Daily *modelForEditing;
@property (weak,nonatomic) DailyViewController *parentDailyController;
-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController;
-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController
                                      ToEdit:(Daily *)daily
                                 AtIndexPath:(NSIndexPath *)rowInfo;
-(void)loadExistingDailyForEditing:(Daily *)daily;
@end
