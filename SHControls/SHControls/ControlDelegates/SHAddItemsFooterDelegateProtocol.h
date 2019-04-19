//
//  SHReminderFooterDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHEventInfo.h"

@protocol SHAddItemsFooterDelegateProtocol <NSObject>
-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo;
@end
