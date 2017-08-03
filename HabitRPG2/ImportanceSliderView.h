//
//  ImportanceSliderViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_ImportanceSlidersDelegate.h"
#import "ControlController.h"

IB_DESIGNABLE
@interface ImportanceSliderView : UIView
@property (weak,nonatomic) IBOutlet UILabel *urgencyLbl;
@property (weak,nonatomic) IBOutlet UISlider *urgencySld;
@property (weak,nonatomic) IBOutlet UILabel *difficultyLbl;
@property (weak,nonatomic) IBOutlet UISlider *difficultySld;
@property (weak,nonatomic) UIView *mainView;
@property (weak,nonatomic) id<P_ImportanceSlidersDelegate> delegate;
@end
