//
//  SHYearPartPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHYearPartPicker.h"
@import SHCommon;

@interface SHYearPartPicker ()
@property (assign,nonatomic) NSInteger numberOfDaysInSelectedMonth;
@end

int const MONTH_COL = 0;
int const DAYS_COL = 1;

@implementation SHYearPartPicker

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker{
	return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
	if(component == MONTH_COL){
		return NSCalendar.SH_appCalendar.monthSymbols.count;
	}
	//if no day setup is needed
	if(self.numberOfDaysInSelectedMonth)
	{
		return self.numberOfDaysInSelectedMonth;
	}
	NSInteger row =[self.picker numberOfRowsInComponent:MONTH_COL]==12?
		[self.picker selectedRowInComponent:MONTH_COL]:0;
	[self setupSelectedMonthLength:row+1];
	return self.numberOfDaysInSelectedMonth;
}


- (NSString * _Nullable)buildTitle:(NSInteger)component row:(NSInteger)row {
	if(component == MONTH_COL){
		return NSCalendar.SH_appCalendar.monthSymbols[row];
	}
	return [NSString stringWithFormat:@"%ld",row + 1];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	if(component==MONTH_COL){
		return 150;
	}
	return 75;
}

#pragma clang diagnostic pop


-(void)setupSelectedMonthLength:(NSInteger)month1Base{
	NSAssert(month1Base>0&&month1Base<13,@"month should between 1 and 12");
	int32_t arbitraryYear = 1972;
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.year = arbitraryYear;
	components.month = month1Base;
	components.day = 1;
	
	NSDate *sampleDate = [NSCalendar.SH_appCalendar dateFromComponents:components];
	NSRange range = [NSCalendar.SH_appCalendar
		rangeOfUnit:NSCalendarUnitDay
		inUnit:NSCalendarUnitMonth
		forDate:sampleDate];
	self.numberOfDaysInSelectedMonth = range.length;
}


-(void)pickerView:(UIPickerView *)pickerView
	didSelectRow:(NSInteger)row
	inComponent:(NSInteger)component
{
	if(component == MONTH_COL){
		[self setupSelectedMonthLength:row+1];
		[pickerView selectRow:0 inComponent:DAYS_COL animated:YES];
		[pickerView reloadComponent:DAYS_COL];
	}
}


@end
