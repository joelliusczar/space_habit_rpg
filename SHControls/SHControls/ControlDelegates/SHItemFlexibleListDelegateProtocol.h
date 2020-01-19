//
//  SHItemFlexibleListDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;


@protocol SHItemFlexibleListDelegateProtocol <NSObject>
@optional
-(void)pickerSelection_action:(SHSpinPicker *)picker;
-(void)addItemBtn_press_action;
-(void)notifyAddNewCell:(NSIndexPath *)indexPath;
-(void)notifyDeleteCell:(NSIndexPath *)eventInfo;
@end
