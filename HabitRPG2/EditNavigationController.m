//
//  EditNewDailyController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "EditNavigationController.h"
#import "EditingSaver.h"
#import "ViewHelper.h"
#import "Interceptor.h"
@import CoreGraphics;


@interface EditNavigationController ()

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIViewController<EditingSaver>* editingScreen;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtnBarItem;
@property (assign,nonatomic) CGFloat defaultScrollHeight;

@end

@implementation EditNavigationController

-(instancetype)initWithTitle:(NSString *)viewTitle
                   andEditor:(UIViewController<EditingSaver>*)editView{
    
    if(self = [self initWithNibName:@"EditNavigationController" bundle:nil]){
        _viewTitle = viewTitle;
        _editingScreen = editView;
    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    self.editingScreen.editorContainer = self;
    self.headline.text = self.viewTitle;
    [self.scrollContainer addSubview:self.editingScreen.view];
    self.defaultScrollHeight = self.scrollContainer.frame.size.height;
    self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width,
                                                  self.editingScreen.view.frame.size.height);
    self.scrollContainer.scrollEnabled = YES;
    [self.scrollContainer sizeToFit];
    UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(background_tap_action:)];
    UITapGestureRecognizer *tapGestureFG = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(background_tap_action:)];
    [self.modalView addGestureRecognizer:tapGestureFG];
    [self.view addGestureRecognizer:tapGestureBG];
    
}


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)deleteBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        [self confirmDelete];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)confirmDelete{
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
        wrapReturnVoid wrappedCall = ^void(){
            [self.editingScreen deleteModel];
            [ViewHelper popViewFromFront:self];
        };
        [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
    }];
    [deleteAlert addAction:noAction];
    [deleteAlert addAction:yesAction];
    [self presentViewController:deleteAlert
                       animated:YES completion:nil];
}

-(IBAction)saveBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        if(self.editingScreen.nameStr.length){
            [self.editingScreen saveEdit];
            [ViewHelper popViewFromFront:self];
            return;
        }
        [self alertMissingInfo];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
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


-(void)background_tap_action:(UITapGestureRecognizer *)sender {
    wrapReturnVoid wrappedCall = ^void(){
        [self.view endEditing:YES];
        if(sender.view == self.view&&self.view.isFocused){
            [ViewHelper popViewFromFront:self];
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
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

@end
