//
//  ImportanceSliderViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHImportanceSlidersDelegateProtocol.h"
#import "SHViewController.h"
#import "SHNumberControlProtocol.h"
@import UIKit;

IB_DESIGNABLE
@interface SHImportanceSliderView : SHViewController<SHNumberControlProtocol>
@property (weak, nonatomic) IBOutlet UILabel *importanceLbl;
@property (weak, nonatomic) IBOutlet UISlider *importanceSld;
@property (strong, nonatomic) NSString *controlName;
@property (weak, nonatomic) id<SHImportanceSlidersDelegateProtocol> delegate;
-(void)updateImportanceSlider:(int32_t)updateValue;
@end
