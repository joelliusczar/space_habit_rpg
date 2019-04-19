//
//  SHDailyEditCompoundProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHNotesViewDelegateProtocol.h"
#import "SHRateSetterDelegateProtocol.h"
#import "SHImportanceSlidersDelegateProtocol.h"
#import "SHStreakResetterDelegateProtocol.h"
#import "SHItemFlexibleListDelegateProtocol.h"

@protocol SHDailyEditCompoundProtocol <NSObject
,SHNotesViewDelegateProtocol
,SHRateSetterDelegateProtocol
,SHImportanceSlidersDelegateProtocol
,SHStreakResetterDelegateProtocol
,SHItemFlexibleListDelegateProtocol>

@end
