//
//  DailyEditResponder.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyEditResponder.h"
#import "Interceptor.h"

@implementation DailyEditResponder


-(DailyEditControlKeep *)editControls{
    if(nil==_editControls){}
    return _editControls;
}


-(instancetype)initWith:(Daily *)daily{
    NSAssert(daily,@"Daily can't be nil");
    
    if(self = [super init]){
        _daily = daily;
    }
    return self;
}


-(void)noteView:(NoteView *)noteView textDidChange:(UITextView *)textView{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        [self.daily noteText_w:textView.text];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        sender.value = [self.daily rate_w:(int)sender.value];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        if(sender.isOn){
            //I'm okay with casting the long to int because I only need the
            //first seven bits anyway
            //TODO: self.modelForEditing.activeDaysHash |= (int)sender.tag;
        }
        else{
            //TODO: self.modelForEditing.activeDaysHash &= ~(int)sender.tag;
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)streakResetBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        [self.daily streak_w:0];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)importanceSlider:(ImportanceSliderView *)sliderView
sld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
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
