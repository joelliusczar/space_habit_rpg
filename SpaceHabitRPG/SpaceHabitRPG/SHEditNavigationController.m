//
//  EditNewDailyController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHEditNavigationController.h"
#import "SHEditingSaverProtocol.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHControls/UIScrollView+ScrollAdjusters.h>
#import <SHGlobal/SHConstants.h>
#import <SHControlsSpecial/SHRateSetContainer.h>
#import <SHControls/SHItemFlexibleListView.h>
#import <SHControls/SHButton.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHControls/UIViewController+Helper.h>
@import CoreGraphics;


@interface SHEditNavigationController ()

@property (strong,nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet SHButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtnBarItem;
@property (assign,nonatomic) CGFloat defaultScrollHeight;
@property (assign,nonatomic) BOOL isKeyboardOpen;
@property (strong,nonatomic) UIGestureRecognizer *tapGestureBG;
@property (strong,nonatomic) UIGestureRecognizer *tapGestureFG;
@end

@implementation SHEditNavigationController

-(instancetype)initWithTitle:(NSString *)viewTitle
                   andEditor:(UIViewController<SHEditingSaverProtocol>*)editView{
    
    if(self = [self initWithNibName:@"SHEditNavigationController" bundle:nil]){
        _viewTitle = viewTitle;
        _editingScreen = editView;
    }
    return self;
}

void setupBackgroundTapActions(SHEditNavigationController *nav){
    nav.tapGestureBG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:nav
                                            action:@selector(background_tap_action:)];
    //the foreground one is tell the keyboard to go away
    nav.tapGestureFG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:nav
                                            action:@selector(background_tap_action:)];
    [nav.modalView addGestureRecognizer:nav.tapGestureFG];
    [nav.background addGestureRecognizer:nav.tapGestureBG];
}

void setupNotificationCenterStuff(SHEditNavigationController *nav){
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:nav
               selector:@selector(noticeShowKeyboard:)
               name:UIKeyboardDidShowNotification
               object:nil];
    [center addObserver:nav
               selector:@selector(noticeHideKeyboard:)
               name:UIKeyboardDidHideNotification
               object:nil];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    self.editingScreen.editorContainer = self;
    self.headline.text = self.viewTitle;
    [self.scrollContainer addSubview:self.editingScreen.view];
    self.defaultScrollHeight = self.scrollContainer.frame.size.height;
    self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width,
                                                  self.editingScreen.view.frame.size.height);
    self.scrollContainer.scrollEnabled = YES;
    [self.scrollContainer sizeToFit];
    setupBackgroundTapActions(self);
    setupNotificationCenterStuff(self);
}


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(void)noticeShowKeyboard:(NSNotification *)notification{
    self.isKeyboardOpen = YES;
}


-(void)noticeHideKeyboard:(NSNotification *)notification{
    self.isKeyboardOpen = NO;
}


-(IBAction)deleteBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
    [self confirmDelete];
}


-(void)confirmDelete{
  __weak SHEditNavigationController *weakSelf = self;
    UIAlertController *deleteAlert = [UIAlertController
                                        alertControllerWithTitle:@"Delete?"
                                        message:@"Are you sure you want to delete this?"
                                        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction
                                 actionWithTitle:@"No"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){}];
    UIAlertAction *yesAction = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    shWrapReturnVoid wrappedCall = ^void(){
                                        [weakSelf.editingScreen deleteModel];
                                        [weakSelf popVCFromFront];
                                    };
                                    [SHInterceptor callVoidWrapped:wrappedCall withInfo:nil];
                                }];
    [deleteAlert addAction:noAction];
    [deleteAlert addAction:yesAction];
    [self presentViewController:deleteAlert
                       animated:YES completion:nil];
}

-(IBAction)saveBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
    if(self.editingScreen.nameStr.length){
        [self.editingScreen saveEdit];
        [self popVCFromFront];
        return;
    }
    [self alertMissingInfo];
}


-(void)alertMissingInfo{
    UIAlertController *saveAlert = [UIAlertController
                                    alertControllerWithTitle:@"Name?"
                                    message:@"Please give this item a name"
                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {}];
    [saveAlert addAction:okAction];
    [self presentViewController:saveAlert animated:YES completion:nil];
}

#pragma clang diagnostic pop


-(void)background_tap_action:(UITapGestureRecognizer *)sender {
  if(self.isKeyboardOpen){
    [self hideKeyboard];
    return;
  }
  if(sender.view == self.background){
    [self.editingScreen unsaved_closing_action];
    [self popVCFromFront];
  }
}


-(void)enableSave{
    self.saveBtnBarItem.enabled = YES;
}


-(void)enableDelete{
    self.deleteBtn.hidden = NO;
}


-(void)resizeScrollView:(BOOL)isXtraOptsHidden{
    if(isXtraOptsHidden){
        self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width,
                                                      self.defaultScrollHeight);
    }
    else{
        self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width,
                   self.editingScreen.view.frame.size.height);
    }
}


-(void)beginUpdate{
    [self.editingScreen.controlsTbl beginUpdates];
}


-(void)scrollByOffset:(CGFloat)offset{
    //scroll past the title control part but no farther for
    //the scrollContainer which houses our editing controls
    if(self.scrollContainer.contentOffset.y < SH_EDIT_SCREEN_TOP_CONTROL_HEIGHT){
        [self.scrollContainer scrollByOffset:offset];
    }
    
}


-(void)scrollVisibleToControl:(SHView *)control{
    NSUInteger rowNum = [self.editControls.controlList indexOfObject:control];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
    [self.editingScreen.controlsTbl scrollToRowAtIndexPath:indexPath
                                          atScrollPosition:UITableViewScrollPositionBottom
                                                  animated:YES];
}


-(void)respondToHeightResize:(CGFloat)change{(void)change;}


-(void)pushViewControllerToNearestParent:(UIViewController *)child{
  [self arrangeAndPushChildVCToFront:child];
}


-(void)endUpdate{
    [self.editingScreen.controlsTbl endUpdates];
}


-(void)refreshView{
    NSArray<NSIndexPath *> *indexPaths = [self.editingScreen.controlsTbl indexPathsForVisibleRows];
    [self.editingScreen.controlsTbl
                    reloadRowsAtIndexPaths:indexPaths
                    withRowAnimation:UITableViewRowAnimationFade];
}


-(void)hideKeyboard{
    [self.view endEditing:YES];
}


-(void)dealloc{
    NSLog(@"SHEditNavigationController deallocating");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
