//
//  YearPartPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "YearPartPicker.h"
#import "NSDate+DateHelper.h"

@interface YearPartPicker ()
@property (assign,nonatomic) NSInteger numberOfDaysInSelectedMonth;
@end

int const MONTH_COL = 0;
int const DAYS_COL = 1;

@implementation YearPartPicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInpickerView:(UIPickerView *)picker{
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(component == MONTH_COL){
        return self.utilityStore.inUseCalendar.monthSymbols.count;
    }
    return self.numberOfDaysInSelectedMonth;
}


-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    if(component == MONTH_COL){
        NSDate *sampleDate = [NSDate createSimpleDate:1972 month:row+1 day:1];
        NSRange range = [self.utilityStore.inUseCalendar
                         rangeOfUnit:NSCalendarUnitDay
                         inUnit:NSCalendarUnitMonth
                         forDate:sampleDate];
        self.numberOfDaysInSelectedMonth = range.length;
        [pickerView selectRow:0 inComponent:DAYS_COL animated:YES];
        [pickerView reloadComponent:DAYS_COL];
    }
}


-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    if(component == MONTH_COL){
        return self.utilityStore.inUseCalendar.monthSymbols[row];
    }
    return [NSString stringWithFormat:@"%ld",row + 1];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 75;
}

@end
