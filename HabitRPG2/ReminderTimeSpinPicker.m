//
//  ReminderTimeSpinPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ReminderTimeSpinPicker.h"

@implementation ReminderTimeSpinPicker

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //hour,minute, days before
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(component==0){
        return 24; //hours
    }
    else if(component==1){
        return 60; //minutes
    }
    else{
        return 0;
    }
}

@end
