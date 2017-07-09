//
//  EditingSaver.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_TaskEditorDelegate.h"

@protocol EditingSaver <NSObject>
@required
@property (weak,nonatomic) UIViewController<P_TaskEditorDelegate> *editorContainer;
@property (assign,nonatomic) BOOL isDirty;
@property (strong,nonatomic) NSString *nameStr;
-(void)saveEdit;
-(BOOL)deleteModel;
@end
