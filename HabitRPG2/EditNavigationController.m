//
//  EditNewDailyController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "EditNavigationController.h"
#import "EditingSaver.h"
@import CoreGraphics;


@interface EditNavigationController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) id<EditingSaver> editingScreen;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;

@end

@implementation EditNavigationController

-(instancetype)initWithTitle:(NSString *)viewTitle AndEditor:(UIViewController<EditingSaver>*)editView{
    if(self = [self initWithNibName:@"EditNavigationController" bundle:nil]){
        self.viewTitle = viewTitle;
        self.editingScreen = editView;
    }
    return self;
}

-(id)initWithTitle:(NSString *)viewTitle{
    if(self = [self initWithNibName:@"EditNavigationController" bundle:nil]){
        self.headline.text = viewTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headline.text = self.viewTitle;
    //self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //self.scrollView.backgroundColor = [UIColor clearColor];
    [self.scrollContainer addSubview:self.editingScreen.view];
    self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width, self.editingScreen.view.frame.size.height);
    //[self.view addSubview:self.scrollView];
    self.scrollContainer.scrollEnabled = YES;
    [self.scrollContainer sizeToFit];
    //[self.view bringSubviewToFront:self.toolbar];
    //[self.view bringSubviewToFront:self.navbar];
    
}

-(void)viewDidLayoutSubviews{
    //self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 900);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pressedLeave:(id)sender{
    [self.editingScreen cancelEdit];
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

- (IBAction)deleteBtn_press_action:(id)sender {
}

- (IBAction)saveBtn_press_action:(id)sender {
}


@end
