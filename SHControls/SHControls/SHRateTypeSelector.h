//
//	SHRateTypeSelector.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/2/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateTypeSelectorDelegateProtocol.h"
#import "SHViewController.h"
#import "SHButton.h"
#import <SHGlobal/SHConstants.h>
@import UIKit;

@interface SHRateTypeSelector : UIViewController
@property (weak,nonatomic) IBOutlet UILabel *everyXCheckLbl;
@property (weak,nonatomic) IBOutlet SHButton *everyXBtn;
@property (weak,nonatomic) IBOutlet UILabel *weeklyCheckLbl;
@property (weak,nonatomic) IBOutlet SHButton *weeklyBtn;
@property (weak,nonatomic) IBOutlet UILabel *monthlyCheckLbl;
@property (weak,nonatomic) IBOutlet SHButton *monthlyBtn;
@property (weak,nonatomic) IBOutlet UILabel *yearlyCheckLbl;
@property (weak,nonatomic) IBOutlet SHButton *yearlyBtn;
@property (weak,nonatomic) IBOutlet UIImageView *backgroundView;
@property (assign,nonatomic) SHRateType rateType;
-(instancetype)initWithRateType:(SHRateType)rateType
	andDelegate:(id<SHRateTypeSelectorDelegateProtocol>)delegate;
@property (weak,nonatomic) id<SHRateTypeSelectorDelegateProtocol> delegate;
@end
