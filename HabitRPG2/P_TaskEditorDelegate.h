//
//  P_TaskEditorDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_TaskEditorDelegate <NSObject>
-(void)enableSave;
-(void)enableDelete;
-(void)resizeScrollView:(BOOL)isXtraOptsHidden;
@end

