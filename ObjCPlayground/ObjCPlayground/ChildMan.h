//
//	ChildMan.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/20/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ParentMan.h"

@interface ChildMan : ParentMan
@property (assign) NSInteger whamjar;
@property (assign,nonatomic) NSInteger whoitZoot;
@property (copy, nonatomic) void (^myBlock)(void);
+(instancetype)newChildMan;
-(void)printShit;
@end
