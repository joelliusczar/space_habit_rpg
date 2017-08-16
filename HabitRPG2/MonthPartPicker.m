//
//  MonthPartPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonthPartPicker.h"
#import "constants.h"
#import "SingletonCluster.h"

@interface MonthPartPicker ()

@end

const NSInteger ORDINAL_COLUMN = 0;
const NSInteger DAY_COLUMN = 1;

@implementation MonthPartPicker


-(id<P_UtilityStore>)utilityStore{
    if(nil==_utilityStore){
        _utilityStore = SharedGlobal;
    }
    return _utilityStore;
}

-(instancetype)init{
    if(self = [super initWithNibName:@"SHSpinPicker" bundle:nil]){}
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
    return self.utilityStore.inUseCalendar.shortWeekdaySymbols.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    
    if(component==ORDINAL_COLUMN){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.locale = self.utilityStore.inUseLocale;
        formatter.numberStyle = NSNumberFormatterOrdinalStyle;
        return [formatter
                stringFromNumber:[NSNumber numberWithInteger:row+1]];
    }
    return self.utilityStore.inUseCalendar.weekdaySymbols[row];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(component==ORDINAL_COLUMN){
        return 50;
    }
    return 75;
}


-(IBAction)pickerSelectBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event{
    if(self.delegate){
        [self.delegate pickerSelection_action:self.picker forEvent:event];
    }
}

@end
