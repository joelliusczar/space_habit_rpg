//
//  SHSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
#import "P_SHSpinPickerDelegate.h"
#import <SHCommon/P_UtilityStore.h>
#import "SHViewController.h"
#import "SHButton.h"

@interface SHSpinPicker : SHViewController
<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak,nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) id<P_UtilityStore> utilityStore;
@property (weak,nonatomic) id<P_SHSpinPickerDelegate> delegate;
-(IBAction)pickerSelectBtn_press_action:(SHButton *)sender
                               forEvent:(UIEvent *)event;
@end
