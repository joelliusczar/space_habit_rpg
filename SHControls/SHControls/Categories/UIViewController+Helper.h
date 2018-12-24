//
//  UIViewController+Helper.h
//  SHControls
//
//  Created by Joel Pridgen on 12/23/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Helper)

//if you want UIViewContoller and its view to be front, call this
-(void)arrangeAndPushChildVCToFront:(UIViewController *)child;
//if you want to get rid of a child view controller, call this
-(void)popChildVCFromFront;

@end

NS_ASSUME_NONNULL_END
