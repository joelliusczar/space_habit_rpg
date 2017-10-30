//
//  RateTypeSelector.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "P_RateTypeSelectorDelegate.h"
#import "constants.h"
#import "SHViewController.h"
@import UIKit;

@interface RateTypeSelector : SHViewController
@property (weak,nonatomic) IBOutlet UILabel *everyXCheckLbl;
@property (weak,nonatomic) IBOutlet UIButton *everyXBtn;
@property (weak,nonatomic) IBOutlet UILabel *weeklyCheckLbl;
@property (weak,nonatomic) IBOutlet UIButton *weeklyBtn;
@property (weak,nonatomic) IBOutlet UILabel *monthlyCheckLbl;
@property (weak,nonatomic) IBOutlet UIButton *monthlyBtn;
@property (weak,nonatomic) IBOutlet UILabel *yearlyCheckLbl;
@property (weak,nonatomic) IBOutlet UIButton *yearlyBtn;
@property (weak,nonatomic) IBOutlet UIImageView *backgroundView;
@property (assign,nonatomic) RateType rateType;
-(instancetype)initWithRateType:(RateType)rateType
                    andDelegate:(id<P_RateTypeSelectorDelegate>)delegate;
@property (weak,nonatomic) id<P_RateTypeSelectorDelegate> delegate;
@end
