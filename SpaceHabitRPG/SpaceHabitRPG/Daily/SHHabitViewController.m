//
//  SHHabitViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHabitViewController.h"
#import "SHHabitNameViewController.h"
#import "SHTablePath.h"
@import SHCommon;


@interface SHHabitViewController ()
@property (strong, nonatomic) UITableView *habitTable;
@property (strong, nonatomic) SHHabitNameViewController *nameViewController;
@property (assign, nonatomic) struct SHSerialQueue *dbQueue; //not owner
@property (assign, nonatomic) const struct SHDatetimeProvider *dateProvider; //not owner
@end

@implementation SHHabitViewController


-(const char*)tableName {
	@throw [NSException abstractException];
}


-(SHHabitNameViewController *)nameViewController {
	if(nil == _nameViewController) {
		_nameViewController = [[SHHabitNameViewController alloc] init];
	}
	return _nameViewController;
}


-(instancetype)initWithCentral:(SHCentralViewController *)central {
	if(self = [self initWithNibName:@"SHHabitViewController" bundle:nil]){
		_central = central;
	}
	return self;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	AppDelegate *appDel = (AppDelegate*)UIApplication.sharedApplication.delegate;
	self.dbQueue = appDel.dbQueue;
	self.dateProvider = appDel.dateProvider;
	self.habitTable = [[UITableView alloc] init];
	[self.view addSubview:self.habitTable];
	self.habitTable.translatesAutoresizingMaskIntoConstraints = NO;
	[self.habitTable.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
	[self.habitTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
	[self.habitTable.topAnchor constraintEqualToAnchor:self.addHabitBtn.bottomAnchor].active = YES;
	self.habitTable.delegate = self;
	self.habitTable.dataSource = self;
	[self.addHabitGesture addTarget:self action:@selector(onAddHabitTap_action:)];
	SHIconBuilder *builder = [[SHIconBuilder alloc] init];
	builder.color = UIColor.whiteColor;
	builder.backgroundColor = [UIColor colorWithRed:36.0/255.0 green:126.0/255.0 blue:217.0/255.0 alpha:1];
	builder.size = CGSizeMake(50, 50);
	builder.thickness = 5;
	UIImage *addHabitIcon = [builder drawPlus];
	[self.addHabitBtnIcon setImage:addHabitIcon];
	[self setupData];
}


-(void)setupData {
	@throw [NSException abstractException];
}


-(void)fetchUpdates{
#warning update
//	[self.context performBlock:^{
//		NSError *error = nil;
//		if(![self.habitItemsFetcher performFetch:&error]){
//			@throw [NSException dbException:error];
//		}
//		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//			[self.habitTable reloadData];
//		}];
//	}];
}


static SHErrorCode _getTableHabit(struct SHTablePath *rowCountObj, struct SHQueueStore *store,
	struct SHTableHabit** result)
{
	*result = NULL;
	struct SHModelsQueueStore *item = (struct SHModelsQueueStore *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_NO_ERROR;
	if(!item || !result) return SH_INVALID_STATE;
	SHHabitViewController *cSelf = (__bridge SHHabitViewController*)rowCountObj->owner;
	struct SHIterableWrapper *tableStorage = SH_modelsQueueStore_selectTableData(item, cSelf.tableName);
	if(!tableStorage) return SH_INVALID_STATE;
	struct SHIterableWrapper *sectionData = SH_iterable_getItemAtIdx(tableStorage, rowCountObj->sectionIdx);
	*result = ((struct SHTableHabit*)SH_iterable_getItemAtIdx(sectionData, rowCountObj->rowIdx));
	return status;
}


static SHErrorCode _getPk(struct SHTablePath *rowCountObj, struct SHQueueStore *store, int64_t* result) {
	*result = SH_NOT_FOUND;
	struct SHTableHabit *tableHabit = NULL;
	SHErrorCode status = SH_NO_ERROR;
	if((status = _getTableHabit(rowCountObj, store, &tableHabit)) != SH_NO_ERROR) { goto fnExit; }
	*result = tableHabit->pk;
	fnExit:
		return status;
}


-(nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
	cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHTablePath rowCountObj = {
		.owner = (__bridge void*)self,
		.sectionIdx = indexPath.section,
	};
	
	struct SHTableHabit *tableHabit = NULL;
	if((status = SH_serialQueue_addOpAndWaitForResult(self.dbQueue,
		(SHErrorCode (*)(void*, struct SHQueueStore *, void**))_getTableHabit, &rowCountObj, NULL, (void**)&tableHabit))
		!= SH_NO_ERROR)
	{
		SH_notifyOfError(status, "app had an error while getting daily section count");
	}
	SHHabitCell *cell = [self getTableCell:tableView];
	[cell setupCell:tableHabit];
	return cell;
}


static SHErrorCode _sectionCount(void* args, struct SHQueueStore *store, uint64_t* result) {
	*result = 0;
	struct SHModelsQueueStore *item = (struct SHModelsQueueStore *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_NO_ERROR;
	if(!item || !result) return SH_INVALID_STATE;
	SHHabitViewController *cSelf = (__bridge SHHabitViewController*)args;
	struct SHIterableWrapper *tableStorage = SH_modelsQueueStore_selectTableData(item, cSelf.tableName);
	if(!tableStorage) return SH_INVALID_STATE;
	*result = SH_iterable_count(tableStorage);
	return status;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	(void)tableView;
	SHErrorCode status = SH_NO_ERROR;
	uint64_t count = 0;
	if((status = SH_serialQueue_addOpAndWaitForResult(self.dbQueue,
		(SHErrorCode (*)(void*, struct SHQueueStore *, void**))_sectionCount, (__bridge void*)self, NULL,
		(void**)&count))
		!= SH_NO_ERROR)
	{
		SH_notifyOfError(status, "app had an error while getting daily section count");
	}
	
	return count;
}


static SHErrorCode _rowCount(struct SHTablePath *rowCountObj, struct SHQueueStore *store, uint64_t* result) {
	*result = 0;
	struct SHModelsQueueStore *item = (struct SHModelsQueueStore *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_NO_ERROR;
	if(!item || !result) return SH_INVALID_STATE;
	SHHabitViewController *cSelf = (__bridge SHHabitViewController*)rowCountObj->owner;
	struct SHIterableWrapper *tableStorage = SH_modelsQueueStore_selectTableData(item, cSelf.tableName);
	if(!tableStorage) return SH_INVALID_STATE;
	struct SHIterableWrapper *sectionData = SH_iterable_getItemAtIdx(tableStorage, rowCountObj->sectionIdx);
	*result = SH_iterable_count(sectionData);
	return status;
}


-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	(void)tableView;
	SHErrorCode status = SH_NO_ERROR;
	uint64_t count = 0;
	struct SHTablePath rowCountObj = {
		.owner = (__bridge void*)self,
		.sectionIdx = section
	};
	if((status = SH_serialQueue_addOpAndWaitForResult(self.dbQueue,
		(SHErrorCode (*)(void*, struct SHQueueStore *, void**))_rowCount, &rowCountObj, NULL,
		(void**)&count))
		!= SH_NO_ERROR)
	{
		SH_notifyOfError(status, "app had an error while getting daily section count");
	}
	
	return count;
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
	(void)controller;
	NSAssert(![NSThread isMainThread],@"this method should only be called from background");
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[self.habitTable beginUpdates];
	}];
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
	(void)controller;
	NSAssert(![NSThread isMainThread],@"this method should only be called from background");
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[self.habitTable endUpdates];
	}];
}


-(void)openEditor:(int64_t)pk forAdded:(BOOL)isAdded {
	SHViewController<SHEditingSaverProtocol> *habitEditor = [self buildHabitEditor];
	[self setupEditorForSaving:habitEditor pk:pk];
	habitEditor.isAdded = isAdded;
	SHEditNavigationController *editNavController = [SHEditNavigationController newWithDefaultNib];
	editNavController.editingScreen = habitEditor;
	editNavController.title = [NSString stringWithUTF8String:self.tableName];
	[self.central arrangeAndPushChildVCToFront:editNavController];
}


-(void)swipeEditActionWithIndexPath:(NSIndexPath*)indexPath
	withCompletionHandler:(void (^)(BOOL))completionHandler
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHTablePath rowCountObj = {
		.owner = (__bridge void*)self,
		.sectionIdx = indexPath.section,
	};
	int64_t pk = SH_NOT_FOUND;
	if((status = SH_serialQueue_addOpAndWaitForResult(self.dbQueue,
		(SHErrorCode (*)(void*, struct SHQueueStore *, void**))_getPk, &rowCountObj, NULL,
		(void**)&pk))
		!= SH_NO_ERROR)
	{
		SH_notifyOfError(status, "app had an error while getting daily section count");
	}
	[self openEditor:pk forAdded:NO];
}


struct _insertArgs {
	struct SHHabitBase *habit;
	void *bSelf;
};


static SHErrorCode _insertNewHabit(void *args, struct SHQueueStore *store) {
	struct _insertArgs *insertArgs = (struct _insertArgs *)args;
	struct SHModelsQueueStore *storeItem = (struct SHModelsQueueStore *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_NO_ERROR;
	int64_t insertedPk = SH_NOT_FOUND;
	SHHabitViewController *bSelf = (__bridge SHHabitViewController*)insertArgs->bSelf;
	if(!bSelf.insertHabit) return SH_LOGIC_MISROUTE;
	if((status = bSelf.insertHabit(storeItem->db, insertArgs->habit, &insertedPk))
		!= SH_NO_ERROR)
	{
		return status;
	}
	[NSOperationQueue.mainQueue addOperationWithBlock:^{
		if(nil == bSelf) return;
		SHHabitNameViewController *nameVC = bSelf.nameViewController;
		[nameVC popVCFromFront];
		[bSelf openEditor: insertedPk forAdded:YES];
		if(bSelf.onOpenAddHabit) {
			bSelf.onOpenAddHabit();
		}
		
	}];
	return status;
}


static void _cleanUpInsert(struct _insertArgs* insertArgs) {
	if(!insertArgs) return;
	SH_freeHabitBase(insertArgs->habit);
	free(insertArgs);
}


//this is wired up to a gesture recognizer
-(void)onAddHabitTap_action:(UIGestureRecognizer *)recognizer {
	(void)recognizer;
	self.nameViewController.namebox.text = @"";
	__weak SHHabitViewController *weakSelf = self;
	
	self.nameViewController.onNext = ^(NSString *name){
		SHHabitViewController *bSelf = weakSelf;
		AppDelegate *appDel = (AppDelegate*)UIApplication.sharedApplication.delegate;
		SHErrorCode status = SH_NO_ERROR;
		double lastUpdated = 0;
		if((status = SH_dtToTimestamp(appDel.dateProvider->getDate(), &lastUpdated)) != SH_NO_ERROR) { goto fnExit; }
		struct SHHabitBase *habit = malloc(sizeof(struct SHHabitBase));
		*habit = (struct SHHabitBase){
			.name = [name SH_unsafeStrCopy],
			.lastUpdated = lastUpdated,
			.tzOffsetLastUpdateDateTime = appDel.dateProvider->getLocalTzOffset(),
		};
		
		struct _insertArgs *insertArgs = malloc(sizeof(struct _insertArgs));
		
		*insertArgs = (struct _insertArgs){
			.habit = habit,
			.bSelf = (__bridge void*)bSelf,
		};
		if((status = SH_serialQueue_addOp(self.dbQueue, _insertNewHabit, insertArgs,(void (*)(void*)) _cleanUpInsert))
			!= SH_NO_ERROR) { goto cleanup; }
		goto fnExit;
		cleanup:
			SH_freeHabitBase(habit);
		fnExit:
			return; 
	};
	self.nameViewController.headline.text = [NSString stringWithUTF8String:self.tableName];
	[self.central arrangeAndPushChildVCToFront:self.nameViewController];
}


-(UISwipeActionsConfiguration*)tableView:(UITableView *)tableView
	trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
	(void)tableView;
	UIContextualAction *editAction = [UIContextualAction
		contextualActionWithStyle:UIContextualActionStyleNormal
		title:@"Edit"
		handler:
			^(UIContextualAction *action,
			UIView *sourceView,
			void (^completionHandler)(BOOL actionPerformed)){
				(void)action; (void)sourceView;
					[self swipeEditActionWithIndexPath:indexPath
						withCompletionHandler:completionHandler];
		}];
	UISwipeActionsConfiguration *actionConfigs = [UISwipeActionsConfiguration
		configurationWithActions:@[editAction]];
	
	return actionConfigs;
}


/*
This will be called the user creates a new habit, checks it off, or deletes one
*/
-(void)controller:(NSFetchedResultsController *)controller
	didChangeObject:(id)anObject
	atIndexPath:(NSIndexPath *)indexPath
	forChangeType:(NSFetchedResultsChangeType)type
	newIndexPath:(NSIndexPath *)newIndexPath
{
	(void)controller; (void)anObject;
	NSAssert(![NSThread isMainThread],@"this method should only be called from background");
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		switch (type) {
			case NSFetchedResultsChangeInsert:
				[self.habitTable insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeUpdate:
				[self configureCellAtIndexPath:indexPath];
				break;
			case NSFetchedResultsChangeDelete:
				[self.habitTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeMove:
				[self configureCellAtIndexPath:indexPath];
				[self.habitTable moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
				break;
			default:
				break;
		}
	}];
}


-(void)controller:(NSFetchedResultsController *)controller
	didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
	atIndex:(NSUInteger)sectionIndex
	forChangeType:(NSFetchedResultsChangeType)type
{
	(void)controller; (void)sectionInfo;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		switch(type) {
			case NSFetchedResultsChangeInsert:
				[self.habitTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
					withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeDelete:
				[self.habitTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
					withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeUpdate:
			case NSFetchedResultsChangeMove:
			default:
				break;
		}
	}];
}


-(void)configureCellAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [self.habitTable cellForRowAtIndexPath:indexPath];
	SHHabitCell *habitCell = (SHHabitCell *)cell;
	[habitCell refreshCell];
}


-(void)setupEditorForSaving:(SHViewController<SHEditingSaverProtocol> *)habitEditor
	pk:(int64_t)pk
{
	AppDelegate *appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;
	[habitEditor setupWithQueue:appDel.dbQueue andPk:pk];
	habitEditor.tableName = self.tableName;
}


-(SHTaskCell *)getTableCell:(UITableView*)tableView {
	(void)tableView;
	@throw [NSException abstractException];
}


-(SHViewController<SHEditingSaverProtocol> *)buildHabitEditor {
	@throw [NSException abstractException];
}


-(void)dealloc {

}

@end
