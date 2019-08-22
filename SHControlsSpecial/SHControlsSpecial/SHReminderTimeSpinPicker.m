//
//	SHReminderTimeSpinPicker.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/2/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHReminderTimeSpinPicker.h"
#import <SHCommon/SHSingletonCluster.h>
#import <SHCommon/NSLocale+Helper.h>
#import <SHGlobal/SHConstants.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>


@interface SHReminderTimeSpinPicker()
@property (assign,nonatomic) BOOL isUpdating;
@end

@implementation SHReminderTimeSpinPicker


-(instancetype)initWithDayRange:(NSInteger)dayRange{
		
	if(self = [super init]){
		_dayRange = dayRange;
	}
	return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	int hrsMinDaysBefore = 3;
	int amPm = 1;
	//if locale uses 24 hour format: hour,minute, days before
	//but if 12 hour, an extra column for AM/PM
	return NSLocale.currentLocale.isUsing24HourFormat?hrsMinDaysBefore:hrsMinDaysBefore+amPm;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
	if(component==SH_HOUR_OF_DAY_COL){
		return SH_HOURS_IN_DAY;
	}
	else if(component==SH_MINUTE_COL){
		return SH_MINUTES_IN_HOUR; 
	}
	else if(!NSLocale.currentLocale.isUsing24HourFormat&&component==SH_AM_PM_COL){
		return SH_AM_PM_COL;
	}
	else{
		return self.dayRange;
	}
}


-(NSString *)pickerView:(UIPickerView *)pickerView
	titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(component==SH_HOUR_OF_DAY_COL){
		return [NSString stringWithFormat:@"%ld",
		 [NSLocale.currentLocale hourInLocaleFormat:row]];
	}
	else if(component==SH_MINUTE_COL){
		return [NSString stringWithFormat:@"%02ld",row];
	}
	else if(!NSLocale.currentLocale.isUsing24HourFormat&&component==SH_AM_PM_COL){
		return row == SH_AM_ROW ? NSLocale.currentLocale.AMSymbol:NSLocale.currentLocale.PMSymbol;
	}
	else{
		return row>0?[NSString stringWithFormat:@"%ld days before",row]:@"Every Day";
	}
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	//these numbers were picked somewhat arbitrarily
	if(component==SH_HOUR_OF_DAY_COL){
		return SH_HOUR_PICKER_COL_WIDTH;
	}
	else if(component==SH_MINUTE_COL){
		return SH_MIN_PICKER_COL_WIDTH;
	}
	else if(!NSLocale.currentLocale.isUsing24HourFormat&&component==SH_AM_PM_COL){
		return SH_AM_PM_PICKER_COL_WIDTH;
	}
	else{
		return SH_LEFTOVER_PICKER_COL_WIDTH;
	}
}

#pragma clang diagnostic pop

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	inComponent:(NSInteger)component
{
	if(self.isUpdating) return;
	if(!NSLocale.currentLocale.isUsing24HourFormat){
		//adjust am/pm if user switches hour to afternoon or morning
		if(component==SH_HOUR_OF_DAY_COL){
			if([pickerView selectedRowInComponent:SH_AM_PM_COL]==SH_AM_ROW
				&&row>=SH_DAY_HALF)
			{
				self.isUpdating = true;
				[pickerView selectRow:SH_PM_ROW inComponent:SH_AM_PM_COL animated:YES];
				self.isUpdating = false;
			}
			else if([pickerView selectedRowInComponent:SH_AM_PM_COL]==SH_PM_ROW
				&&row<SH_DAY_HALF)
			{
				self.isUpdating = true;
				[pickerView selectRow:SH_AM_ROW inComponent:SH_AM_PM_COL animated:YES];
				self.isUpdating = false;
			}
		}
		//adjust hour if user switches am/pm
		else if(component==SH_AM_PM_COL){
			NSInteger currentHour = [pickerView selectedRowInComponent:SH_HOUR_OF_DAY_COL];

			if(row==SH_AM_ROW&&currentHour>=SH_DAY_HALF){
				self.isUpdating = true;
				[pickerView selectRow:currentHour%SH_DAY_HALF inComponent:SH_HOUR_OF_DAY_COL animated:YES];
				self.isUpdating = false;
			}
			else if(row==SH_PM_ROW&&currentHour<SH_DAY_HALF){
				self.isUpdating = true;
				[pickerView selectRow:currentHour+SH_DAY_HALF inComponent:SH_HOUR_OF_DAY_COL animated:YES];
				self.isUpdating = false;
			}
		}
	}
}

@end
