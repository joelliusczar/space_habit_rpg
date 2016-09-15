//
//  EditNewDailyController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "EditNavigationController.h"
@import CoreGraphics;

@interface EditNavigationController ()

@property (nonatomic,strong) UIToolbar *toolbar;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) UIView *editingView;

@end

@implementation EditNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    
    [self.scrollView addSubview:self.editingView];
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = YES;
    
    self.toolbar = [self.view viewWithTag:1];
    [self.view bringSubviewToFront:self.toolbar];
}

-(void)viewDidLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 800);
}

-(void)setupView:(UIView *)editView{
    self.editingView = editView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
