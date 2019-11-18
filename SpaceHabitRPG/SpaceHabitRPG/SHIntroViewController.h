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
@property (copy,nonatomic) void (^onNextAction)(void);
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithOnNextAction:(void (^)(void))onNextAction
	withContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil;
@end

