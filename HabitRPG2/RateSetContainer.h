//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import "RateSetterView.h"
#import "SHView.h"

@interface RateSetContainer : SHView
@property (weak,nonatomic) IBOutlet UIButton *openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView *activeDaysView;
@property (weak,nonatomic) IBOutlet RateSetterView *rateSetter;
@end
