//
//  SHIntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHModels;


@interface SHIntroViewController : UIViewController
@property (copy,nonatomic) void (^skipAction)(void);
@property (copy,nonatomic) void (^onNextAction)(void);
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithSkipAction:(void (^)(void))skipAction
	withOnNextAction:(void (^)(void))onNextAction
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil;
@end

