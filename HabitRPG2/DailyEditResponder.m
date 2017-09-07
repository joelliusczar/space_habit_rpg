//
//  DailyEditResponder.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyEditResponder.h"
#import "Interceptor.h"
#import "SHEventInfo.h"
#import "RateTypeHelper.h"

@implementation DailyEditResponder


-(DailyEditControlKeep *)editControls{
    if(nil==_editControls){
        _editControls = [[DailyEditControlKeep alloc] init];
        _editControls.delegate = self;
    }
    return _editControls;
}


-(instancetype)initWith:(Daily *)daily{
    NSAssert(daily,@"Daily can't be nil");
    
    if(self = [super init]){
        _daily = daily;
    }
    return self;
}


-(void)textDidChange:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        UITextView *textView = (UITextView *)eventInfo.senderStack[0];
        [self.daily noteText_w:textView.text];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        UIStepper *sender = (UIStepper *)eventInfo.senderStack[0];
        sender.value = [self.daily rate_w:(int)sender.value];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)activeDaySwitch_press_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        CustomSwitch *sender = (CustomSwitch *)eventInfo.senderStack[0];
        [self.daily flipDayOfWeek_w:sender.dayKey setTo:sender.isOn for:isInverseRateType(self.daily.rateType)];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)streakResetBtn_press_action:(SHEventInfo *)eventInfo {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        [self.daily streak_w:0];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)sld_valueChanged_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        UISlider *sender = (UISlider *)eventInfo.senderStack[0];
        ImportanceSliderView *sliderView = (ImportanceSliderView *)eventInfo.senderStack[1];
        int sliderValue = (int)sender.value;
        if(sliderView == self.editControls.urgencySlider){
            sliderView.importanceSld.value = [self.daily urgency_w:sliderValue];
            sliderView.importanceLbl.text = [NSString stringWithFormat:@"Urgency: %d",sliderValue];
        }
        else{
            sliderView.importanceSld.value = [self.daily difficulty_w:sliderValue];
            sliderView.importanceLbl.text = [NSString stringWithFormat:@"Difficulty: %d",sliderValue];
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

-(void)dealloc{
    _editControls = nil;
}

@end
