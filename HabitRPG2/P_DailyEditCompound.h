//
//  P_DailyEditCompound.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_NotesViewDelegate.h"
#import "P_ActiveDaysPickerDelegate.h"
#import "P_RateSetterDelegate.h"
#import "P_ImportanceSlidersDelegate.h"
#import "P_StreakResetterDelegate.h"

@protocol P_DailyEditCompound <NSObject,P_NotesViewDelegate,P_ActiveDaysPickerDelegate,P_RateSetterDelegate,P_ImportanceSlidersDelegate,P_StreakResetterDelegate>

@end
