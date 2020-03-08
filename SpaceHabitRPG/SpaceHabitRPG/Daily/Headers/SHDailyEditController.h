//
//	SHDailyEditController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/15/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyViewController.h"
#import "SHEditingSaverProtocol.h"
@import UIKit;


@import SHModels;
@import SHControls;


NS_ASSUME_NONNULL_BEGIN

@interface SHDailyEditController : SHViewController
<SHEditingSaverProtocol
,SHNotesViewDelegateProtocol
,SHImportanceSlidersDelegateProtocol
,UITableViewDataSource
,UITableViewDelegate>
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
@end

NS_ASSUME_NONNULL_END

#import "SHDailyEditController+ControlLoaders.h"
