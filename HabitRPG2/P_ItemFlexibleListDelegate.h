//
//  P_ItemFlexibleListDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@class ItemFlexibleListEventInfo;

#import <Foundation/Foundation.h>
#import "SHEventInfo.h"
#import "ItemFlexibleListEventInfo.h"


@protocol P_ItemFlexibleListDelegate <NSObject>
@optional
-(void)pickerSelection_action:(SHEventInfo *)eventInfo;
-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo;
-(void)notifyAddNewCell:(ItemFlexibleListEventInfo *)eventInfo;
-(void)notifyDeleteCell:(ItemFlexibleListEventInfo *)eventInfo;
@end
