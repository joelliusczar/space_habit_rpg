//
//  P_SHSpinPickerDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_SHSpinPickerDelegate <NSObject>
-(void)pickerSelection_action:(UIPickerView *)sender
                     forEvent:(UIEvent *)event;
@end
