//
//	UIViewController+Helper.h
//	SHControls
//
//	Created by Joel Pridgen on 12/23/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Helper)

-(void)popAllChildVCs;

-(void)showErrorView:(NSString*)name withError:(NSError*)error;
@end

NS_ASSUME_NONNULL_END
