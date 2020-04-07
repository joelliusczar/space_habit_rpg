//
//  SHMonthPartPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHMonthPartPicker.h"

@import SHCommon;
@import SHControls;

@interface SHMonthPartPicker ()
@end

const NSInteger ORDINAL_WEEK_COLUMN = 0;
const NSInteger DAY_COLUMN = 1;

@implementation SHMonthPartPicker


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	(void)pickerView;
	return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
	numberOfRowsInComponent:(NSInteger)component
{
	(void)pickerView;
	if(component == ORDINAL_WEEK_COLUMN){
		return SH_POTENTIAL_WEEKS_IN_MONTH_NUM;
	}
	return NSCalendar.currentCalendar.shortWeekdaySymbols.count;
}


-(NSString * _Nullable)buildTitle:(NSInteger)component row:(NSInteger)row {
	if(component == ORDINAL_WEEK_COLUMN){
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		formatter.locale = NSLocale.currentLocale;
		formatter.numberStyle = NSNumberFormatterOrdinalStyle;
		NSString *formatted = [formatter
													 stringFromNumber:[NSNumber numberWithInteger:row + 1]];
		return formatted;
	}
	NSString *day = NSCalendar.currentCalendar.weekdaySymbols[row];
	return day;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	(void)pickerView;
	NSLog(@"width");
	if(component == ORDINAL_WEEK_COLUMN){
		return 150;
	}
	return 150;
}



@end
