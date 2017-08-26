//
//  P_ItemFlexibleListDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemFlexibleListView;

@protocol P_ItemFlexibleListDelegate <NSObject>
@optional
-(void)pickerSelection_action:(UIPickerView *)picker
          onItemFlexibleList:(ItemFlexibleListView *)itemFlexibleList
                     forEvent:(UIEvent *)event;
-(void)addItemBtn_press_action:(UIButton *)sender
            onItemFlexibleList:(ItemFlexibleListView *)itemFlexibleList
                      forEvent:(UIEvent *)event;
@end
