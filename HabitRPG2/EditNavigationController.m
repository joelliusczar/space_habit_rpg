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
@property (nonatomic,strong) UINavigationBar *navbar;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) UIBarButtonItem *deleteBtn;
@property (nonatomic,weak) UIBarButtonItem *saveBtn;
@property (nonatomic,assign) id<EditingSaver> editingScreen;
@property (nonatomic,weak) UINavigationItem *navItem;
@property (nonatomic,weak) UIBarButtonItem *leaveBtn;

@end

@implementation EditNavigationController

@synthesize toolbar = _toolbar;
-(UIToolbar *)toolbar{
    if(_toolbar == nil){
        _toolbar = [self.view viewWithTag:1];
    }
    return _toolbar;
}

@synthesize navbar = _navbar;
-(UINavigationBar *)navbar{
    if(_navbar == nil){
        _navbar = [self.view viewWithTag:2];
    }
    return _navbar;
}


@synthesize deleteBtn = _deleteBtn;
-(UIBarButtonItem *)deleteBtn{
    if(_deleteBtn == nil){
        _deleteBtn = [self.toolbar.items objectAtIndex:0];
        _deleteBtn.target = self;
        _deleteBtn.action = @selector(pressedDelete:);
    }
    return _deleteBtn;
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

@synthesize navItem = _navItem;
-(UINavigationItem *)navItem{
    if(_navItem == nil){
        _navItem = [self.navbar.items objectAtIndex:0];
        
    }
    return _navItem;
}

@synthesize leaveBtn = _leaveBtn;
-(UIBarButtonItem *)leaveBtn{
    if(_leaveBtn == nil){
        _leaveBtn = self.navItem.leftBarButtonItem;
        _leaveBtn.title = @"Cancel";
        _leaveBtn.target = self;
        _leaveBtn.action = @selector(pressedLeave:);
    }
    return _leaveBtn;
}


-(id)initWithTitle:(NSString *)viewTitle{
    if(self = [self initWithNibName:@"EditNavigationController" bundle:nil]){
        self.viewTitle = viewTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.navbar.delegate = self;
    self.navItem.title = self.viewTitle;
    [self.scrollView addSubview:self.editingScreen.view];
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = YES;
    [self.view bringSubviewToFront:self.toolbar];
    [self.view bringSubviewToFront:self.navbar];
    [self leaveBtn];
    [self deleteBtn];
    [self saveBtn];
    
}

-(void)viewDidLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 900);
}

-(void)setupTaskEditor:(id<EditingSaver>)editView{
    self.editingScreen = editView;
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
