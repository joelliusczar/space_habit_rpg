//
//	SHDailyEditController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/15/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyViewController.h"
#import "SHEditingSaverProtocol.h"
#import "SHRepeatLinkViewController.h"
#import "SHRemindersLinkViewController.h"
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
//@property (strong,nonatomic) SHDailyActiveDays *activeDays;
@property (strong, nonatomic) SHNoteView *note;
@property (strong, nonatomic) SHRepeatLinkViewController *repeatLink;
@property (strong, nonatomic) SHRemindersLinkViewController *remindersLink;
@property (strong, nonatomic) SHImportanceSliderView *difficultySld;
@property (strong, nonatomic) SHImportanceSliderView *urgencySld;
@property (strong, nonatomic) SHStreakResetterView *resetter;
@end

NS_ASSUME_NONNULL_END

