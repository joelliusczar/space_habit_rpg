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
@import CoreGraphics;


@interface EditNavigationController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) UIViewController<EditingSaver>* editingScreen;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;

@end

@implementation EditNavigationController

-(instancetype)initWithTitle:(NSString *)viewTitle AndEditor:(UIViewController<EditingSaver>*)editView{
    if(self = [self initWithNibName:@"EditNavigationController" bundle:nil]){
        _viewTitle = viewTitle;
        _editingScreen = editView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editingScreen.delegate = self;
    self.headline.text = self.viewTitle;
    [self.scrollContainer addSubview:self.editingScreen.view];
    self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width, self.editingScreen.view.frame.size.height);
    self.scrollContainer.scrollEnabled = YES;
    [self.scrollContainer sizeToFit];
    UITapGestureRecognizer *tapGesturebg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(background_tap_action:)];
    UITapGestureRecognizer *tapGesturefg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(background_tap_action:)];
    [self.modalView addGestureRecognizer:tapGesturefg];
    [self.view addGestureRecognizer:tapGesturebg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pressedLeave:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)pressedDelete:(id)sender{
    [self.editingScreen deleteModel];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)pressedSave:(id)sender{
    [self.editingScreen saveEdit];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)deleteBtn_press_action:(id)sender{
}

- (IBAction)saveBtn_press_action:(id)sender{
}

-(void)background_tap_action:(UITapGestureRecognizer *)sender {
    if(sender.view != self.modalView){
        [ViewHelper popViewFromFront:self];
    }
}

-(void)enableSave{
    self.saveBtn.enabled = YES;
}

-(void)enableDelete{
    self.deleteBtn.enabled = YES;
}

@end
