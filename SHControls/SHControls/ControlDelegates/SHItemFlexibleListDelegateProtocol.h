//
//  SHItemFlexibleListDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@class SHItemFlexibleListEventInfo;

#import <Foundation/Foundation.h>
#import "SHEventInfo.h"
#import "SHItemFlexibleListEventInfo.h"


@protocol SHItemFlexibleListDelegateProtocol <NSObject>
@optional
-(void)pickerSelection_action:(SHEventInfo *)eventInfo;
-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo;
-(void)notifyAddNewCell:(SHItemFlexibleListEventInfo *)eventInfo;
-(void)notifyDeleteCell:(SHItemFlexibleListEventInfo *)eventInfo;
@end
