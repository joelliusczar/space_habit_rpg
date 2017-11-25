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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker{
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if(component == MONTH_COL){
        return self.utilityStore.inUseCalendar.monthSymbols.count;
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


-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    if(component == MONTH_COL){
        return self.utilityStore.inUseCalendar.monthSymbols[row];
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
    
    NSDate *sampleDate = [NSDate createSimpleDate:1972 month:month1Base day:1];
    NSRange range = [self.utilityStore.inUseCalendar
                     rangeOfUnit:NSCalendarUnitDay
                     inUnit:NSCalendarUnitMonth
                     forDate:sampleDate];
    self.numberOfDaysInSelectedMonth = range.length;
}


-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    if(component == MONTH_COL){
        [self setupSelectedMonthLength:row+1];
        [pickerView selectRow:0 inComponent:DAYS_COL animated:YES];
        [pickerView reloadComponent:DAYS_COL];
    }
}


@end