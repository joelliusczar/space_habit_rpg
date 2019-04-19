//
//  SHSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
#import "SHSpinPickerDelegateProtocol.h"
#import "SHViewController.h"
#import "SHButton.h"

@interface SHSpinPicker : SHViewController
<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak,nonatomic) IBOutlet UIPickerView *picker;
@property (weak,nonatomic) id<SHSpinPickerDelegateProtocol> delegate;
-(IBAction)pickerSelectBtn_press_action:(SHButton *)sender
                               forEvent:(UIEvent *)event;
@end
