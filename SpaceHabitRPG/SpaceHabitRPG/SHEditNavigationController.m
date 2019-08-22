//
//	EditNewDailyController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/11/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHEditNavigationController.h"
#import "SHEditingSaverProtocol.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHControls/UIScrollView+ScrollAdjusters.h>
#import <SHGlobal/SHConstants.h>
#import <SHControls/SHItemFlexibleListView.h>
#import <SHControls/SHButton.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHModels/SHTitleProtocol.h>
#import <SHData/NSManagedObjectContext+Helper.h>
@import CoreGraphics;


@interface SHEditNavigationController ()

@property (weak,nonatomic) IBOutlet UILabel *headline;
@property (weak,nonatomic) IBOutlet UIImageView *background; //unused
@property (weak,nonatomic) IBOutlet UIBarButtonItem *deleteBtn;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *saveBtnBarItem;
@property (strong,nonatomic) IBOutlet UINavigationBar *topNavBar;
@property (assign,nonatomic) CGFloat defaultScrollHeight;
@property (assign,nonatomic) BOOL isKeyboardOpen;
@property (strong,nonatomic) UIGestureRecognizer *tapGestureFG;
@end

@implementation SHEditNavigationController

-(instancetype)init{
	if(self = [self initWithNibName:@"SHEditScreenFull" bundle:nil]){}
	return self;
}

-(void)setupBackgroundTapActions{

	self.tapGestureFG = [[UITapGestureRecognizer alloc]
		initWithTarget:self
		action:@selector(background_tap_action:)];
	[self.view addGestureRecognizer:self.tapGestureFG];
}

-(void)setupNotificationCenterStuff{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self
		selector:@selector(noticeShowKeyboard:)
		name:UIKeyboardDidShowNotification
		object:nil];
	[center addObserver:self
		selector:@selector(noticeHideKeyboard:)
		name:UIKeyboardDidHideNotification
		object:nil];
}


-(void)viewDidLoad {
	[super viewDidLoad];
	//[self.view layoutIfNeeded];
	self.editingScreen.editorContainerController = self;
	self.topNavBar.topItem.title = self.viewTitle;

	[self addChildViewController:self.editingScreen];
	[self.editorSubviewContainer addSubview: self.editingScreen.view];
	[self.editingScreen didMoveToParentViewController:self];
	UIView *editView = self.editingScreen.view;
	editView.translatesAutoresizingMaskIntoConstraints = NO;
	[editView.topAnchor constraintEqualToAnchor:self.editorSubviewContainer.topAnchor].active = YES;
	[editView.leadingAnchor constraintEqualToAnchor:self.editorSubviewContainer.leadingAnchor].active = YES;
	[editView.widthAnchor constraintEqualToAnchor:self.editorSubviewContainer.widthAnchor].active = YES;
	[editView.heightAnchor constraintEqualToAnchor:self.editorSubviewContainer.heightAnchor].active = YES;
	//[self.editorContainer tieConstaintsForsubordinateView:self.editingScreen.view];
//	[self.scrollContainer addSubview:self.editingScreen.view];
//	self.defaultScrollHeight = self.scrollContainer.frame.size.height;
//	self.scrollContainer.contentSize = CGSizeMake(self.scrollContainer.frame.size.width,
//																								self.editingScreen.view.frame.size.height);
//	self.scrollContainer.scrollEnabled = YES;
//	[self.scrollContainer sizeToFit];
	[self setupBackgroundTapActions];
	[self setupNotificationCenterStuff];
}


-(void)didReceiveMemoryWarning {
		[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}


-(void)noticeShowKeyboard:(NSNotification *)notification{
	(void)notification;
	self.isKeyboardOpen = YES;
}


-(void)noticeHideKeyboard:(NSNotification *)notification{
	(void)notification;
	self.isKeyboardOpen = NO;
}


-(IBAction)deleteBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	[self confirmDelete];
}


-(void)confirmDelete{
	__weak typeof(self) weakSelf = self;
	UIAlertController *deleteAlert = [UIAlertController
		alertControllerWithTitle:@"Delete?"
		message:@"Are you sure you want to delete this?"
		preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *noAction = [UIAlertAction
	 actionWithTitle:@"No"
	 style:UIAlertActionStyleDefault
	 handler:^(UIAlertAction *action){(void)action;}];
	UIAlertAction *yesAction = [UIAlertAction
		actionWithTitle:@"Yes"
		style:UIAlertActionStyleDefault
		handler:^(UIAlertAction *action){
			typeof(weakSelf) bSelf = weakSelf;
			if(nil == bSelf) return;
			[bSelf.editingScreen deleteModel];
			[bSelf popVCFromFront];
			(void)action;
		}];
	[deleteAlert addAction:noAction];
	[deleteAlert addAction:yesAction];
	[self presentViewController:deleteAlert animated:YES completion:nil];
}

-(IBAction)saveBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	if(self.itemNameInput.text.length){
		[self.editingScreen saveEdit];
		[self popVCFromFront];
		return;
	}
	[self alertMissingInfo];
}


-(IBAction)nameBox_editingChange_action:(UITextField *)sender forEvent:(UIEvent *)event {
	(void)event;
	NSAssert(self.context,@"You need a context, bro!");
	NSString *text = sender.text;
	[self.context performBlock:^{
		id<SHTitleProtocol> model = (id<SHTitleProtocol>)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		model.title = text;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self enableSave];
		}];
	}];
}


-(void)alertMissingInfo{
	UIAlertController *saveAlert = [UIAlertController
		alertControllerWithTitle:@"Name?"
		message:@"Please give this item a name"
		preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *okAction = [UIAlertAction
		actionWithTitle:@"OK"
		style:UIAlertActionStyleDefault
		handler:^(UIAlertAction *action) {(void)action;}];
	[saveAlert addAction:okAction];
	[self presentViewController:saveAlert animated:YES completion:nil];
}


-(void)background_tap_action:(UITapGestureRecognizer *)sender {
	if(self.isKeyboardOpen){
		[self hideKeyboard];
		sender.cancelsTouchesInView = YES;
		return;
	}
	sender.cancelsTouchesInView = NO;
}


-(void)enableSave{
	self.saveBtnBarItem.enabled = YES;
}


-(void)enableDelete{
	self.deleteBtn.enabled = NO;
}


-(void)beginUpdate{
	[self.editingScreen.controlsTbl beginUpdates];
}


-(void)scrollVisibleToControl:(SHView *)control{
	NSUInteger rowNum = [self.editControls.controlList indexOfObject:control];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
	[self.editingScreen.controlsTbl scrollToRowAtIndexPath:indexPath
		atScrollPosition:UITableViewScrollPositionBottom
		animated:YES];
}


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
