//
//  ImportanceSliderViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_ImportanceSlidersDelegate.h"
#import "SHView.h"
#import "P_NumberControl.h"

IB_DESIGNABLE
@interface ImportanceSliderView : SHView<P_NumberControl>
@property (weak,nonatomic) IBOutlet UILabel *importanceLbl;
@property (weak,nonatomic) IBOutlet UISlider *importanceSld;
@property (strong,nonatomic) NSString *controlName;
@property (weak,nonatomic) id<P_ImportanceSlidersDelegate> delegate;
-(void)updateImportanceSlider:(int)updVal;
@end
