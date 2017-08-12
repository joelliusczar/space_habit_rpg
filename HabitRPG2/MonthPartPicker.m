//
//  MonthPartPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonthPartPicker.h"
#import "constants.h"

@interface MonthPartPicker ()

@end

const NSInteger ORDINAL_COLUMN = 0;
const NSInteger DAY_COLUMN = 1;

@implementation MonthPartPicker

-(instancetype)initWithTimeStore:(NSObject<P_TimeUtilityStore> *)timeStore{
    if(self = [self init]){
        _timeStore = timeStore;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return POTENTIAL_WEEKS_IN_MONTH_NUM;
    }
    return self.timeStore.inUseCalendar.shortWeekdaySymbols.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    
    if(component==ORDINAL_COLUMN){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.locale = self.timeStore.inUseLocale;
        formatter.numberStyle = NSNumberFormatterOrdinalStyle;
        return [formatter
                stringFromNumber:[NSNumber numberWithInteger:row]];
    }
    return self.timeStore.inUseCalendar.shortWeekdaySymbols[row];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 200;
}

@end
