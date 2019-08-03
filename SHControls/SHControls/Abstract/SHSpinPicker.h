//
//  SHSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
#import "SHViewController.h"
#import "SHButton.h"
#import "SHSpinPicker.h"

@class SHSpinPicker;

typedef void (^shSpinPickerAction)(SHSpinPicker *,BOOL *);

@interface SHSpinPicker : SHViewController
<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak,nonatomic) IBOutlet UIPickerView *picker;
@property (copy,nonatomic) shSpinPickerAction spinPickerAction;
-(IBAction)pickerSelectBtn_press_action:(SHButton *)sender
  forEvent:(UIEvent *)event;
-(void)animateInvalidSelection;
-(NSInteger)selectedRowInComponent:(NSInteger)component;
@end
