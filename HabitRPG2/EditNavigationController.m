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

@property (nonatomic,strong) UIToolbar *toolbar;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIBarButtonItem *cancelBtn;
@property (nonatomic,strong) UIBarButtonItem *saveBtn;
@property (nonatomic,assign) id<EditingSaver> editingScreen;


@end

@implementation EditNavigationController

@synthesize toolbar = _toolbar;
-(UIToolbar *)toolbar{
    if(_toolbar == nil){
        _toolbar = [self.view viewWithTag:1];
    }
    return _toolbar;
}

@synthesize cancelBtn = _cancelBtn;
-(UIBarButtonItem *)cancelBtn{
    if(_cancelBtn == nil){
        _cancelBtn = [self.toolbar.items objectAtIndex:0];
        _cancelBtn.target = self;
        _cancelBtn.action = @selector(pressedCancel:);
    }
    return _cancelBtn;
}

@synthesize saveBtn = _saveBtn;
-(UIBarButtonItem *)saveBtn{
    
    if(_saveBtn == nil){
        _saveBtn = [self.toolbar.items objectAtIndex:2];
        _saveBtn.target = self;
        _saveBtn.action = @selector(pressedSave:);
        
    }
    return _saveBtn;
}


-(id)initCustom{

    return [self initWithNibName:@"EditNavigationController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    
    [self.scrollView addSubview:self.editingScreen.view];
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = YES;
    
    [self.view bringSubviewToFront:self.toolbar];
    [self cancelBtn];
    [self saveBtn];
    
}

-(void)viewDidLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 900);
}

-(void)setupTaskEditor:(id<EditingSaver>)editView{
    self.editingScreen = editView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pressedCancel:(id)sender{
    [self.editingScreen cancelEdit];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)pressedSave:(id)sender{
    NSLog(@"save click");
    [self.editingScreen saveEdit];
    [self dismissViewControllerAnimated:NO completion:nil];
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
