//
//  P_ResizeResponder.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHView.h"

@protocol P_ResizeResponder <NSObject>
@required
-(void)pushViewControllerToNearestParent:(UIViewController *)child;
-(void)hideKeyboard;
@optional
-(void)respondToHeightResize:(CGFloat)change;
-(void)scrollByOffset:(CGFloat)offset;
-(void)scrollVisibleToControl:(SHView *)control;
-(void)beginUpdate;
-(void)endUpdate;
-(void)resetHeight;
-(void)refreshView;
@end