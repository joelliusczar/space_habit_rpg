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
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_getUserItemFromStore(store);
	if((status = SH_fetchSingleDaily(storeItem->db, editController.pk, editController.daily) ) != SH_NO_ERROR) { ; }
	struct SHDaily *daily = editController.daily;
	[NSOperationQueue.mainQueue addOperationWithBlock:^{
		editController.note.noteBox.text = [NSString stringWithUTF8String:daily->note];
		[editController.difficultySld updateImportanceSlider:daily->difficulty];
		[editController.urgencySld updateImportanceSlider:daily->urgency];
	}];
	return status;
}


static void _dailyCleanup(void *arg) {
	struct SHDaily *daily = (struct SHDaily *)arg;
	SH_freeDaily(daily);
}


-(void)setupWithQueue:(struct SHSerialQueue *)queue andPk:(int64_t)pk {
	SHErrorCode status = SH_NO_ERROR;
	self.pk = pk;
	self.queue = queue;
	self.daily = malloc(sizeof(struct SHDaily));
	self.editorContainerController.habit = (struct SHHabitBase *)self.daily;
	self.editorContainerController.habitCleanup = _dailyCleanup;
	if((status = SH_addOp(queue, _fetchDaily, (__bridge void *)(self), NULL)) != SH_NO_ERROR) { ; }
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

	[self setupEditControls];
	[self afterloadFinishSetup];
	
	self.controlsTbl.hidden = YES;
	//it is important that this table delegate stuff happens after we check
	//for the existence of the model, otherwise table events will trigger
	//at inconvienient times, and either invalid data or null pointer exceptions
	//will happen
	self.controlsTbl.dataSource = self;
	self.controlsTbl.delegate = self;
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
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_getUserItemFromStore(store);
	if((status = SH_updateDaily(storeItem->db, editController.daily) ) != SH_NO_ERROR) { ; }
	return status;
}

-(void)saveEdit{
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_addOp(self.queue, _updateDaily, (__bridge void*)self, NULL)) != SH_NO_ERROR) {}
}


static SHErrorCode _deleteDaily(void *args, struct SHQueueStore *store) {
	SHErrorCode status = SH_NO_ERROR;
	SHDailyEditController *editController = (__bridge SHDailyEditController *)args;
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_getUserItemFromStore(store);
	if((status = SH_deleteRecord(storeItem->db, editController.tableName, editController.pk) ) != SH_NO_ERROR) { ; }
	return status;
}


-(void)deleteModel{
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_addOp(self.queue, _deleteDaily, (__bridge void*)self, NULL)) != SH_NO_ERROR) {}
}


-(void)afterloadFinishSetup{
//	if(self.objectIDWrapper.objectID){
//		[self.context performBlock:^{
//			SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
//			NSString *dailyName = daily.dailyName;
//			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//				self.nameBox.text = dailyName;
//
//			}];
//		}];
//	}
}


-(void)textDidChange:(SHNoteView *)sender{
	NSString *note = sender.noteBox.text;
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
	
//	NSManagedObjectContext *context = self.context;
//	SHObjectIDWrapper *objectIDWrapper = self.objectIDWrapper;
//	//SHDailyActiveDays *activeDays = self.activeDays;
//	__block SHIntervalType rateType = SH_WEEKLY_INTERVAL;
//	__block NSString *noteText = @"";
//	__block int32_t difficulty = 3;
//	__block int32_t urgency = 3;
//	__block BOOL newlyInserted = YES;
//	__block int32_t streakLength = 0;
//	[context performBlockAndWait:^{
//		SHDaily_x *daily = (SHDaily_x*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
//		rateType = daily.intervalType;
//		noteText = daily.note.length > 0 ? daily.note : @"";
//		difficulty = daily.difficulty;
//		urgency = daily.urgency;
//		newlyInserted = daily.inserted;
//		streakLength = daily.streakLength;
//	}];
//
	self.note = [[SHNoteView alloc] init];
	self.note.delegate = self;
	[keep addObject:self.note];
//
	NSBundle *appBundle = [NSBundle bundleForClass:SHRepeatLinkViewController.class];
	self.repeatLink = [[SHRepeatLinkViewController alloc]
		initWithNibName:@"SHLinkViewController" bundle:appBundle];
	self.repeatLink.editorContainer = self.editorContainerController;
//	[repeatLink setupWithContext:context
//		andObjectID:objectIDWrapper];
//	//repeatLink.activeDays = activeDays;
//	repeatLink.rateType = rateType;
	[keep addObject:self.repeatLink];
//
	self.remindersLink = [[SHRemindersLinkViewController alloc]
		initWithNibName:@"SHLinkViewController" bundle:appBundle];
	self.remindersLink.editorContainer = self.editorContainerController;
//	[remindersLink setupWithContext:context
//		andObjectID:objectIDWrapper];
	[keep addObject:self.remindersLink];
//
	NSBundle *shControlsBundle = [NSBundle bundleForClass:SHImportanceSliderView.class];
	self.difficultySld = [[SHImportanceSliderView alloc]
		initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
		bundle:shControlsBundle];
	self.difficultySld.controlName = @"difficulty";
	self.difficultySld.delegate = self;
	[keep addObject:self.difficultySld];
//
	self.urgencySld = [[SHImportanceSliderView alloc]
		initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
		bundle:shControlsBundle];
	self.urgencySld.controlName = @"urgency";
	self.urgencySld.delegate = self;
	[keep addObject:self.urgencySld];
//
	self.resetter = [[SHStreakResetterView alloc]
		initWithNibName:NSStringFromClass(SHStreakResetterView.class)
		bundle:shControlsBundle];
//	resetter.streakCountLbl.hidden = !newlyInserted;
//	resetter.streakResetBtn.hidden = !newlyInserted;
//	resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",streakLength];
	[keep addObject:self.resetter];
//
	return keep;
}


@end
