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
@optional
-(void)respondToHeightResize:(CGFloat)change;
-(void)scrollByOffset:(CGFloat)offset;
-(void)scrollVisibleToControl:(SHView *)control;
-(void)beginUpdate;
-(void)endUpdate;
-(void)pushViewControllerToNearestParent:(UIViewController *)child;
@end
