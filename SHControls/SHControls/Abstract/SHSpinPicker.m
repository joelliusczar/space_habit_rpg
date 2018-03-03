//
//  SHSpinPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHSpinPicker.h"
#import <SHCommon/Interceptor.h>
#import <SHCommon/ViewHelper.h>
#import <SHCommon/NSException+SHCommonExceptions.h>
#import <SHCommon/SingletonCluster.h>
#import "SHEventInfo.h"

@interface SHSpinPicker ()

@end

@implementation SHSpinPicker


-(id<P_UtilityStore>)utilityStore{
    if(nil==_utilityStore){
        _utilityStore = SharedGlobal;
    }
    return _utilityStore;
}


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
    wrapReturnVoid wrappedCall = ^void(){
        if(sender.view==self.view){
            popVCFromFront(self);
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
    wrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = [[SHEventInfo alloc] init:event withSenders:sender,self.picker,self,nil];
        [self.delegate pickerSelection_action:e];
        popVCFromFront(self);
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
