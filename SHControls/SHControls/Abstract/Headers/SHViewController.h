//
//	SHViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHViewController : UIViewController
@property (weak, nonatomic) SHViewController *prevViewController;
-(void)pushChildVC:(SHViewController*)child toViewOfParent:(UIView*)view;
//if you want UIViewContoller and its view to be front, call this
-(void)arrangeAndPushChildVCToFront:(SHViewController *)child;
//if you want to get rid of a child view controller, call this
-(void)popVCFromFront;
-(void)popAllChildVCs;
@end

NS_ASSUME_NONNULL_END

#import "SHViewController+SHAppearance.h"
