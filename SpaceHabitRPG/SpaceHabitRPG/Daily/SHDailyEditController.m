//
//	SHDailyEditController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/15/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyEditController.h"
@import SHCommon;
@import SHModels;
@import SHControls;



@interface SHDailyEditController ()
@property (assign, nonatomic) shDailyStatus section;
@property (assign, nonatomic) BOOL isStreakReset;
@property (strong, nonatomic) NSMutableArray<SHViewController *> *editControls;
@property (assign, nonatomic) BOOL isEditingExisting;
@property (assign, nonatomic) struct SHDaily *daily;
@property (assign, nonatomic) struct SHSerialQueue *queue;
@end

@implementation SHDailyEditController

//These need to be synthesized since they come from a protocol
@synthesize editorContainerController = _editorContainerController;
@synthesize nameStr = _nameStr;
@synthesize controlsTbl = _controlsTbl;
@synthesize pk = _pk;
@synthesize tableName = _tableName;
@synthesize isAdded = _isAdded;


-(UITextField *)nameBox {
	return self.editorContainerController.itemNameInput;
}


-(instancetype)init {
	if(self = [super init]){
		_controlsTbl = [[UITableView alloc] init];
	}
	return self;
}


static SHErrorCode _fetchDaily(void *args, struct SHQueueStore *store) {
	SHErrorCode status = SH_NO_ERROR;
	SHDailyEditController *editController = (__bridge SHDailyEditController *)args;
	[NSOperationQueue.mainQueue addOperationWithBlock:^{
		[editController showLoadingDisplay:YES];
	}];
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_serialQueue_getUserItem(store);
	if((status = SH_fetchSingleDaily(storeItem->db, editController.pk, editController.daily) ) != SH_NO_ERROR) {
		return status;
	}
	struct SHDaily *daily = editController.daily;
	[NSOperationQueue.mainQueue addOperationWithBlock:^{
		[editController setupEditControls];
		[editController showLoadingDisplay: NO];
		editController.editorContainerController.itemNameInput.text = [NSString stringWithUTF8String:daily->base.name];
		editController.repeatLink.activeDays = &(editController.daily->activeDays);
		editController.note.noteBox.text = [NSString stringWithUTF8String:daily->note];
		[editController.difficultySld updateImportanceSlider:daily->difficulty];
		[editController.urgencySld updateImportanceSlider:daily->urgency];
		editController.resetter.streakCountLbl.hidden = editController.isAdded;
		editController.resetter.streakResetBtn.hidden = editController.isAdded;
		editController.resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",daily->streakLength];
	}];
	return status;
}


-(void)setupWithQueue:(struct SHSerialQueue *)queue andPk:(int64_t)pk {
	SHErrorCode status = SH_NO_ERROR;
	self.pk = pk;
	self.queue = queue;
	//dealloc happens in the dealloc method for SHEditNavigationController
	//where it frees the habit property which we are assigning this daily to
	self.daily = malloc(sizeof(struct SHDaily));
	self.editorContainerController.habit = (struct SHHabitBase *)self.daily;
	self.editorContainerController.habitCleanup = (void (*)(void**))SH_freeDaily;
	if((status = SH_serialQueue_addOp(queue, _fetchDaily, (__bridge void *)(self), NULL)) != SH_NO_ERROR) { ; }
}

/*
	This is an override
*/
-(void)loadView {
	self.view = _controlsTbl;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	self.controlsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
	//it is important that this table delegate stuff happens after we check
	//for the existence of the model, otherwise table events will trigger
	//at inconvienient times, and either invalid data or null pointer exceptions
	//will happen
	self.controlsTbl.dataSource = self;
	self.controlsTbl.delegate = self;
}


-(void)showLoadingDisplay:(BOOL)isLoading {
	self.controlsTbl.hidden = isLoading;
}

-(void)setupEditControls {
	//I want the editControls stuff to happen here because when it gets
	//lazy loaded, it gets out of hand
	
	self.editControls = [self buildControlList];
	self.editorContainerController.editControls = self.editControls;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	(void)tableView;(void)section;
	NSInteger count = self.editControls.count;
	return count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	(void)tableView;
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	SHViewController *cellViewController = self.editControls[indexPath.row];
	UIView *view = cellViewController.view;
	view.translatesAutoresizingMaskIntoConstraints = NO;

	[self addChildViewController:cellViewController];
	[cell.contentView addSubview:view];
	[cellViewController didMoveToParentViewController:self];
	
	[view.heightAnchor constraintEqualToConstant:view.frame.size.height].active = YES;
	[view.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor].active = YES;
	[view.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor].active = YES;
	[view.widthAnchor constraintEqualToAnchor:cell.contentView.widthAnchor].active = YES;
	return cell;
}


-(CGFloat)tableView:(UITableView *)tableView
	heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	(void)tableView;
	CGFloat height = self.editControls[indexPath.row].view.frame.size.height;
	return height;
}


-(void)streakResetBtn_press_action {
	self.daily->streakLength = 0;
}


static SHErrorCode _updateDaily(void *args, struct SHQueueStore *store) {
	SHErrorCode status = SH_NO_ERROR;
	SHDailyEditController *editController = (__bridge SHDailyEditController *)args;
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_serialQueue_getUserItem(store);
	if((status = SH_updateDaily(storeItem->db, editController.daily) ) != SH_NO_ERROR) { ; }
	return status;
}


-(void)saveEdit{
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_serialQueue_addOp(self.queue, _updateDaily, (__bridge void*)self, NULL)) != SH_NO_ERROR) {}
}


static SHErrorCode _deleteDaily(void *args, struct SHQueueStore *store) {
	SHErrorCode status = SH_NO_ERROR;
	SHDailyEditController *editController = (__bridge SHDailyEditController *)args;
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_serialQueue_getUserItem(store);
	if((status = SH_deleteRecord(storeItem->db, editController.tableName, editController.pk) ) != SH_NO_ERROR) { ; }
	return status;
}


-(void)deleteModel{
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_serialQueue_addOp(self.queue, _deleteDaily, (__bridge void*)self, NULL)) != SH_NO_ERROR) {}
}


-(void)textDidChange:(SHNoteView *)sender{
	NSString *note = sender.noteBox.text;
	if(self.daily->note) free(self.daily->note);
	self.daily->note = [note SH_unsafeStrCopy];
}


-(void)sld_valueChanged_action:(SHImportanceSliderView *)sender{
	int32_t sliderValue = shCheckImportanceRange((int32_t)sender.importanceSld.value);
	[sender updateImportanceSlider:sliderValue];
	BOOL isUrgency = [sender.controlName isEqualToString:@"urgency"];
	if(isUrgency) {
		self.daily->urgency = sliderValue;
	}
	else {
		self.daily->difficulty = sliderValue;
	}
}


-(NSMutableArray<SHViewController *> *)buildControlList{
	//NSAssert(self.activeDays,@"Active days shouldn't be nil");
	NSMutableArray<SHViewController *> *keep = [NSMutableArray array];
	
	self.note = [[SHNoteView alloc] init];
	self.note.delegate = self;
	[keep addObject:self.note];

	NSBundle *appBundle = [NSBundle bundleForClass:SHRepeatLinkViewController.class];
	self.repeatLink = [[SHRepeatLinkViewController alloc]
		initWithNibName:@"SHLinkViewController" bundle:appBundle];
	self.repeatLink.editorContainer = self.editorContainerController;
	[keep addObject:self.repeatLink];

	self.remindersLink = [[SHRemindersLinkViewController alloc]
		initWithNibName:@"SHLinkViewController" bundle:appBundle];
	self.remindersLink.editorContainer = self.editorContainerController;
	[keep addObject:self.remindersLink];

	NSBundle *shControlsBundle = [NSBundle bundleForClass:SHImportanceSliderView.class];
	self.difficultySld = [[SHImportanceSliderView alloc]
		initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
		bundle:shControlsBundle];
	self.difficultySld.controlName = @"difficulty";
	self.difficultySld.delegate = self;
	[keep addObject:self.difficultySld];

	self.urgencySld = [[SHImportanceSliderView alloc]
		initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
		bundle:shControlsBundle];
	self.urgencySld.controlName = @"urgency";
	self.urgencySld.delegate = self;
	[keep addObject:self.urgencySld];

	self.resetter = [[SHStreakResetterView alloc]
		initWithNibName:NSStringFromClass(SHStreakResetterView.class)
		bundle:shControlsBundle];
	[keep addObject:self.resetter];

	return keep;
}


@end
