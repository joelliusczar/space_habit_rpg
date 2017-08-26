//
//  EditNewDailyController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingSaver.h"
#import "P_ResizeResponder.h"
#import "P_EditControlKeep.h"


@interface EditNavigationController : UIViewController<P_ResizeResponder>
@property (strong,nonatomic) NSString *viewTitle;
@property (strong,nonatomic) UIViewController<EditingSaver>* editingScreen;
@property (weak,nonatomic) id<P_EditControlKeep> editControls;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
-(instancetype)initWithTitle:(NSString *)viewTitle
                   andEditor:(UIViewController<EditingSaver>*)editView;
-(void)enableSave;
-(void)enableDelete;
-(void)resizeScrollView:(BOOL)isXtraOptsHidden;
-(void)scrollByOffset:(CGFloat)offset;
@end
