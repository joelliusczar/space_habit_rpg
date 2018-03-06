//
//  ImportanceSliderViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ImportanceSliderView.h"
#import "P_CommonDelegate.h"
#import <SHCommon/NSObject+Helper.h>
#import "SHEventInfo.h"

@interface ImportanceSliderView ()

@end

@implementation ImportanceSliderView


-(IBAction)importanceSld_valueChanged_action:(UISlider *)sender
                                    forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = eventInfoCopy;
        [self.delegate sld_valueChanged_action:e];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

-(double)value{
    return self.importanceSld.value;
}

-(void)setValue:(double)value{
    self.importanceSld.value = value;
}


-(void)updateImportanceSlider:(int)updVal{
    self.importanceSld.value = updVal;
    self.importanceLbl.text = [NSString stringWithFormat:@"%@: %d",self.controlName,updVal];
}


@end