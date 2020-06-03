//
//  SHEditingSaverProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHEditNavigationController.h"
@import Foundation;
@import UIKit;
@import SHCommon;

@class SHEditNavigationController;

@protocol SHEditingSaverProtocol <NSObject>
@required
@property (weak,nonatomic) SHEditNavigationController *editorContainerController;
@property (readonly, nonatomic) UITextField *nameBox;
@property (strong, nonatomic) UITableView *controlsTbl;
@property (strong, nonatomic) NSString *nameStr;
@property (assign, nonatomic) int64_t pk;
@property (assign, nonatomic) const char * tableName;
-(void)saveEdit;
-(void)deleteModel;
-(void)setupWithQueue:(struct SHSerialQueue*)queue
	andPk:(int64_t)pk;

@optional
-(void)unsaved_closing_action;
@end
