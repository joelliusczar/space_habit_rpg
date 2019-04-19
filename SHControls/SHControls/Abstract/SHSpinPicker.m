//
//  SHSpinPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHSpinPicker.h"
#import <SHCommon/SHInterceptor.h>
#import <SHCommon/NSException+SHCommonExceptions.h>
#import <SHCommon/SHSingletonCluster.h>
#import "UIViewController+Helper.h"
#import "SHEventInfo.h"

@interface SHSpinPicker ()

@end

@implementation SHSpinPicker


-(instancetype)init{
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"SHSpinPicker")];
    if(self = [super initWithNibName:@"SHSpinPicker" bundle:bundle]){}
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(background_tap_action:)];
    [self.view addGestureRecognizer:tapGestureBG];
}


-(void)background_tap_action:(UITapGestureRecognizer *)sender{
    shWrapReturnVoid wrappedCall = ^void(){
        if(sender.view==self.view){
            [self popVCFromFront];
        }
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
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


-(IBAction)pickerSelectBtn_press_action:(SHButton *)sender
            forEvent:(UIEvent *)event
{
    shWrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = [[SHEventInfo alloc] init:event withSenders:sender,self.picker,self,nil];
        [self.delegate pickerSelection_action:e];
        [self popVCFromFront];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
