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


-(instancetype)init{
  NSBundle *bundle = [NSBundle bundleForClass:SHRateSetterView.class];
  if(self = [super initWithNibName:@"SHRateSetterView" bundle:bundle]){}
  return self;
}

- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
  if(self.rateStepEvent){
    self.rateStepEvent(sender,event);
  }
}


@end
