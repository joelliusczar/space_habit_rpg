//
//  EditNewDailyController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHEditingSaverProtocol.h"
#import <SHControls/SHResizeResponderProtocol.h>
#import <SHCommon/SHControlKeep.h>


@interface SHEditNavigationController : UIViewController//<SHResizeResponderProtocol>
@property (strong,nonatomic) NSString *viewTitle;
@property (strong,nonatomic) UIViewController<SHEditingSaverProtocol>* editingScreen;
@property (weak,nonatomic) SHControlKeep *editControls;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
@property (strong,nonatomic) IBOutlet UITextField *itemNameInput;
@property (strong,nonatomic) IBOutlet UIView *editorSubviewContainer;
-(void)enableSave;
-(void)enableDelete;
-(void)scrollByOffset:(CGFloat)offset;
@end
