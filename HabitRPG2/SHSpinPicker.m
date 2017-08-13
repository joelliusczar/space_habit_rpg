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

@interface SHSpinPicker ()

@end

@implementation SHSpinPicker

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
    @throw [NSException
            exceptionWithName:@"abstract method exception"
            reason:@"This method needs to be implemented in a subclass"
            userInfo:nil];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    @throw [NSException
            exceptionWithName:@"abstract method exception"
            reason:@"This method needs to be implemented in a subclass"
            userInfo:nil];
}


-(IBAction)pickerSelectBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event{
    @throw [NSException
            exceptionWithName:@"abstract method exception"
            reason:@"This method needs to be implemented in a subclass"
            userInfo:nil];
}

@end
