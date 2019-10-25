//
//  EditNewDailyController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHEditingSaverProtocol.h"
@import UIKit;
@import SHControls;
@import SHCommon;
@import SHData;



@interface SHEditNavigationController : UIViewController
@property (strong,nonatomic) NSString *viewTitle;
@property (strong,nonatomic) UIViewController<SHEditingSaverProtocol>* editingScreen;
@property (weak,nonatomic) SHControlKeep *editControls;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
@property (strong,nonatomic) IBOutlet UITextField *itemNameInput;
@property (strong,nonatomic) IBOutlet UIView *editorSubviewContainer;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
@property (strong,nonatomic) NSManagedObjectContext *context;
-(void)enableSave;
-(void)enableDelete;
@end
