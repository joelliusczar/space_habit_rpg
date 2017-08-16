//
//  ReminderTimeSpinPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ReminderTimeSpinPicker.h"
#import "SingletonCluster.h"
#import "NSLocale+Helper.h"
#import "constants.h"
#import "ViewHelper.h"
#import "Interceptor.h"

const int HOUR_OF_DAY_COL = 0;
const int MINUTE_COL = 1;
const int DAYS_BEFORE_COL_IN_24_HOUR_CLOCK = 2;
const int DAYS_BEFORE_COL_IN_12_HOUR_CLOCK = 3;
const int AM_PM_COL = 2;
const int AM_ROW = 0;
const int PM_ROW = 1;

@interface ReminderTimeSpinPicker()
@end

@implementation ReminderTimeSpinPicker


-(id<P_UtilityStore>)utilityStore{
    if(nil==_utilityStore){
        _utilityStore = SharedGlobal;
    }
    return _utilityStore;
}

-(instancetype)initWithDayRange:(NSInteger)dayRange{
    
    if(self = [super initWithNibName:@"SHSpinPicker" bundle:nil]){
        _dayRange = dayRange;
    }
    return self;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    int hrsMinDaysBefore = 3;
    int amPm = 1;
    //if locale uses 24 hour format: hour,minute, days before
    //but if 12 hour, an extra column for AM/PM
    return self.utilityStore.inUseLocale.isUsing24HourFormat?hrsMinDaysBefore:hrsMinDaysBefore+amPm;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(component==HOUR_OF_DAY_COL){
        return HOURS_IN_DAY;
    }
    else if(component==MINUTE_COL){
        return MINUTES_IN_HOUR; 
    }
    else if(!self.utilityStore.inUseLocale.isUsing24HourFormat&&component==AM_PM_COL){
        return 2;
    }
    else{
        return self.dayRange;
    }
}


-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component==HOUR_OF_DAY_COL){
        return
        [NSString stringWithFormat:@"%ld",
         [self.utilityStore.inUseLocale hourInLocaleFormat:row]];
    }
    else if(component==MINUTE_COL){
        return [NSString stringWithFormat:@"%02ld",row];
    }
    else if(!self.utilityStore.inUseLocale.isUsing24HourFormat&&component==AM_PM_COL){

        return
        row==AM_ROW?self.utilityStore.inUseLocale.AMSymbol:self.utilityStore.inUseLocale.PMSymbol;
    }
    else{
        return row>0?[NSString stringWithFormat:@"%ld days before",row]:@"Every Day";
    }
}


-(IBAction)pickerSelectBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event {
    if(self.delegate){
        TimeSpinPickerEventInfo *eventInfo = [TimeSpinPickerEventInfo new];
        eventInfo.selectedHourRow =
        [self.picker selectedRowInComponent:HOUR_OF_DAY_COL];
        
        eventInfo.selectedMinRow =
        [self.picker selectedRowInComponent:MINUTE_COL];
        NSInteger daysCol =
        self.utilityStore.inUseLocale.isUsing24HourFormat?DAYS_BEFORE_COL_IN_24_HOUR_CLOCK:DAYS_BEFORE_COL_IN_12_HOUR_CLOCK;
        
        eventInfo.selectedDaysBeforeRow =
        [self.picker selectedRowInComponent:daysCol];
        
        [self.delegate pickerSelection_action:self.picker
                                     forEvent:eventInfo];
    }
    [ViewHelper popViewFromFront:self];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    //these numbers were picked somewhat arbitrarily
    if(component==HOUR_OF_DAY_COL){
        return 35;
    }
    else if(component==MINUTE_COL){
        return 40;
    }
    else if(!self.utilityStore.inUseLocale.isUsing24HourFormat&&component==AM_PM_COL){
        return 45;
    }
    else{
        return 200;
    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    
    if(!self.utilityStore.inUseLocale.isUsing24HourFormat){
        //adjust am/pm if user switches hour to afternoon or morning
        if(component==HOUR_OF_DAY_COL){
            if([pickerView selectedRowInComponent:AM_PM_COL]==AM_ROW
               &&row>=DAY_HALF){
                [pickerView selectRow:PM_ROW
                          inComponent:AM_PM_COL animated:YES];
            }
            else if([pickerView selectedRowInComponent:AM_PM_COL]==PM_ROW
                    &&row<DAY_HALF){
                [pickerView selectRow:AM_ROW
                          inComponent:AM_PM_COL animated:YES];
            }
        }
        //adjust hour if user switches am/pm
        else if(component==AM_PM_COL){
            NSInteger currentHour = [pickerView
                               selectedRowInComponent:HOUR_OF_DAY_COL];
            
            if(row==AM_ROW&&currentHour>=DAY_HALF){
                [pickerView selectRow:currentHour%DAY_HALF
                          inComponent:HOUR_OF_DAY_COL animated:YES];
            }
            else if(row==PM_ROW&&currentHour<DAY_HALF){
                [pickerView selectRow:currentHour+DAY_HALF
                          inComponent:HOUR_OF_DAY_COL animated:YES];
            }
        }
    }
}

@end
