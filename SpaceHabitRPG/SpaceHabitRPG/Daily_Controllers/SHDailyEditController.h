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
#import <SHData/SHObjectIDWrapper.h>


NS_ASSUME_NONNULL_BEGIN

@interface SHDailyEditController : UIViewController
<SHEditingSaverProtocol
,SHDailyEditCompoundProtocol
,UITableViewDataSource
,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet SHTextField *nameBox;
@property (weak,nonatomic) IBOutlet SHButton *showXtraOptsBtn;
@property (weak,nonatomic) IBOutlet UITableView *controlsTbl;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
-(void)setupForContext:(NSManagedObjectContext*)context
  andObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper;

-(void)modelTouched;
@end

NS_ASSUME_NONNULL_END

#import "SHDailyEditController+ControlLoaders.h"
