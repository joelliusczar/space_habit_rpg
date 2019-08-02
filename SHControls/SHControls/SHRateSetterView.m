//
//  rateSetterViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetterView.h"
#import "EventArgs/SHEventInfo.h"

@interface SHRateSetterView ()

@end

@implementation SHRateSetterView


-(void)setIntervalSize:(NSInteger)intervalSize{
  _intervalSize = intervalSize;
  [self updateLabelTextWithInterval:intervalSize];
}


-(void)setupCustomOptions{
  [super setupCustomOptions];
  if(self.controlBackground){
    self.backgroundColor = self.controlBackground;
    self.mainView.backgroundColor = self.controlBackground;
  }
}


-(void)updateLabelTextWithInterval:(NSInteger)intervalValue{
  NSString *useFormatString = intervalValue == 1 ?
    self.labelSingularFormatString :
    self.labelPluralFormatString;
  if(nil == useFormatString) return;
  self.intervalLabel.text = [NSString stringWithFormat:useFormatString,intervalValue];
}


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
  NSInteger intervalValue = (NSInteger)sender.value;
  [self updateLabelTextWithInterval:intervalValue];
  if(self.rateStepEvent){
    self.rateStepEvent(sender,event);
  }
}

-(void)prepareForInterfaceBuilder{
  [super prepareForInterfaceBuilder];
  if(self.controlBackground){
    self.backgroundColor = self.controlBackground;
    self.mainView.backgroundColor = self.controlBackground;
  }
}


-(void)setSubControlColorsTo:(UIColor *)color {
  self.rateStep.tintColor = color;
  self.intervalLabel.textColor = color;
  if(self.mainView) {
    NSAssert(self.mainView.subviews.count == 2,@"Some adjustments need to be made in a control");
    UIStepper *stepper =  (UIStepper*)[self.mainView viewWithTag:self.rateStep.tag];
    UILabel *label = (UILabel*)[self.mainView viewWithTag:self.intervalLabel.tag];
    stepper.tintColor = color;
    label.textColor = color;
    
  }
}
@end
