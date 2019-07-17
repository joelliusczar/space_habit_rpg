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
@end
