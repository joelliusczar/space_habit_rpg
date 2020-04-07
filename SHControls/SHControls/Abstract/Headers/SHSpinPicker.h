//
//	SHSpinPicker.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/2/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
#import "SHViewController.h"
#import "SHSpinPicker.h"


@class SHSpinPicker;

NS_ASSUME_NONNULL_BEGIN
typedef void (^shSpinPickerAction)(SHSpinPicker *_Nonnull,BOOL *);

@interface SHSpinPicker :  SHViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (copy, nonatomic) shSpinPickerAction spinPickerAction;
@property (strong, nonatomic) UIColor *pickerBackground UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *cellTextColor UI_APPEARANCE_SELECTOR;
-(IBAction)pickerSelectBtn_press_action:(UIButton *)sender
	forEvent:(UIEvent *)event;
-(void)animateInvalidSelection;
-(NSInteger)selectedRowInComponent:(NSInteger)component;
-(NSString * _Nullable)buildTitle:(NSInteger)component
	row:(NSInteger)row;
@end
NS_ASSUME_NONNULL_END
