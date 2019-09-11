//
//  SHIntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHConfig.h>
#import <SHModels/SHSector_Medium.h>
#import <SHModels/SHSectorDTO.h>
#import "SHCentralViewController.h"



@interface SHIntroViewController : UIViewController
@property (copy,nonatomic) void (^skipAction)(void);
@property (copy,nonatomic) void (^onNextAction)(void);
-(instancetype)initWithSkipAction:(void (^)(void))skipAction withOnNextAction:(void (^)(void))onNextAction;
@end

