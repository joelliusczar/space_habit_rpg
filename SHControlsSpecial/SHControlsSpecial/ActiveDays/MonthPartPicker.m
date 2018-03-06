//
//  MonthPartPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonthPartPicker.h"
#import <SHGlobal/Constants.h>
#import <SHCommon/SingletonCluster.h>
#import <SHCommon/ViewHelper.h>

@interface MonthPartPicker ()

@end

const NSInteger ORDINAL_WEEK_COLUMN = 0;
const NSInteger DAY_COLUMN = 1;

@implementation MonthPartPicker


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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return POTENTIAL_WEEKS_IN_MONTH_NUM;
    }
    return self.utilityStore.inUseCalendar.shortWeekdaySymbols.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    
    if(component==ORDINAL_WEEK_COLUMN){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.locale = self.utilityStore.inUseLocale;
        formatter.numberStyle = NSNumberFormatterOrdinalStyle;
        return [formatter
                stringFromNumber:[NSNumber numberWithInteger:row+1]];
    }
    return self.utilityStore.inUseCalendar.weekdaySymbols[row];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(component==ORDINAL_WEEK_COLUMN){
        return 50;
    }
    return 150;
}

#pragma clang diagnostic pop


@end