//
//  EditingSaver.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditNavigationController.h"

@class EditNavigationController;

@protocol EditingSaver <NSObject>
@required
@property (weak,nonatomic) EditNavigationController *editorContainer;
@property (weak,nonatomic) UITextField *nameBox;
@property (weak,nonatomic) UIButton *showXtraOptsBtn;
@property (weak,nonatomic) UITableView *controlsTbl;
@property (assign,nonatomic) BOOL isDirty;
@property (strong,nonatomic) NSString *nameStr;
-(void)saveEdit;
-(BOOL)deleteModel;
@end
