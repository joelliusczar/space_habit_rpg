//
//  SHSpinPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSpinPicker.h"
#import "Interceptor.h"
#import "ViewHelper.h"
#import "NSException+SHCommonExceptions.h"

@interface SHSpinPicker ()

@end

@implementation SHSpinPicker


-(instancetype)init{
    if(self = [super initWithNibName:@"SHSpinPicker" bundle:nil]){}
    return self;
}


-(void)viewDidLoad{
    UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(background_tap_action:)];
    [self.view addGestureRecognizer:tapGestureBG];
}


-(void)background_tap_action:(UITapGestureRecognizer *)sender{
    wrapReturnVoid wrappedCall = ^void(){
        if(sender.view==self.view){
            [ViewHelper popViewFromFront:self];
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    @throw [NSException abstractException];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    @throw [NSException abstractException];
}


-(IBAction)pickerSelectBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event{
    @throw [NSException abstractException];
}

@end
