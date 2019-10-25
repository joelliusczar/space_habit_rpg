//
//	SHRepeatLinkViewController.h
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 6/22/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHLinkViewController.h"
@import UIKit;
@import SHModels;
@import SHControls;

NS_ASSUME_NONNULL_BEGIN

@interface SHRepeatLinkViewController : SHLinkViewController
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
@end

NS_ASSUME_NONNULL_END
