//
//  SHHabitViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHabitViewController.h"
#import "SHHabitNameViewController.h"
@import SHCommon;


@interface SHHabitViewController ()
@property (strong, nonatomic) UITableView *habitTable;
@property (strong, nonatomic) SHHabitNameViewController *nameViewController;
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


-(nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
	cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
#warning update
return nil;
//		SHHabitCell *cell = [self getTableCell:tableView];
//	__block NSManagedObjectID *objectID = nil;
//	[self.context performBlockAndWait:^{
//		NSManagedObject *mananagedObject = (NSManagedObject*)self.habitItemsFetcher
//			.sections[indexPath.section]
//			.objects[indexPath.row];
//		objectID = mananagedObject.objectID;
//	}];
//	SHContextObjectIDWrapper *wrappedID = [[SHContextObjectIDWrapper alloc]
//		initWithEntityType:self.entityType
//		withContext:self.context];
//	wrappedID.objectID = objectID;
//	[cell setupCell:wrappedID];
//	return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	(void)tableView;
	#warning update
	return 0;
//	NSInteger sectionCount = self.habitItemsFetcher.sections.count;
//	return sectionCount;
}


-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	(void)tableView;
	#warning update
	return 0;
//	NSInteger rowCount = self.habitItemsFetcher.sections[section].numberOfObjects;
//	return rowCount;
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


-(void)openEditor:(int64_t)pk {
	SHViewController<SHEditingSaverProtocol> *habitEditor = [self buildHabitEditor];
	[self setupEditorForSaving:habitEditor pk:pk];
	
	SHEditNavigationController *editNavController = [SHEditNavigationController newWithDefaultNib];
	editNavController.editingScreen = habitEditor;
	editNavController.title = [NSString stringWithUTF8String:self.tableName];
	[self.central arrangeAndPushChildVCToFront:editNavController];
}


-(void)swipeEditActionWithIndexPath:(NSIndexPath*)indexPath
	withCompletionHandler:(void (^)(BOOL))completionHandler
{
#warning update without nsfetchresultscontroller
//	NSFetchedResultsController *fetchController = self.habitItemsFetcher;
//	NSManagedObjectContext *fetchContext = fetchController.managedObjectContext;
//	[fetchContext performBlockAndWait:^{
//		NSManagedObject *rowObject = fetchController.fetchedObjects[indexPath.row];
//		SHContextObjectIDWrapper *objectIDWrapper = [[SHContextObjectIDWrapper alloc]
//			initWithManagedObject:rowObject];
//		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//			[self openEditor:objectIDWrapper];
//			completionHandler(YES);
//		}];
//	}];
}


struct _insertArgs {
	struct SHHabitBase *habit;
	SHHabitViewController *bSelf;
};


static SHErrorCode _insertNewHabit(void *args, struct SHQueueStore *store) {
	struct _insertArgs *insertArgs = (struct _insertArgs *)args;
	struct SHQueueStoreItem *storeItem = (struct SHQueueStoreItem *)SH_getUserItemFromStore(store);
	SHErrorCode status = SH_NO_ERROR;
	int64_t insertedPk = SH_NOT_FOUND;
	SHHabitViewController *bSelf = insertArgs->bSelf;
	if((status = SH_insertHabit(storeItem->db, insertArgs->habit, bSelf.tableName, &insertedPk))
		!= SH_NO_ERROR)
	{
		return status;
	}
	[NSOperationQueue.mainQueue addOperationWithBlock:^{
		if(nil == bSelf) return;
		SHHabitNameViewController *nameVC = bSelf.nameViewController;
		[nameVC popVCFromFront];
		[bSelf openEditor: insertedPk];
		if(bSelf.onOpenAddHabit) {
			bSelf.onOpenAddHabit();
		}
		
	}];
	return status;
}


static void _cleanUpInsert(void* args) {
	struct _insertArgs *insertArgs = (struct _insertArgs *)args;
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
		struct SHHabitBase *habit = malloc(sizeof(struct SHHabitBase));
		*habit = (struct SHHabitBase){
			.name = [name SH_unsafeStrCopy],
		};
		struct _insertArgs *insertArgs = malloc(sizeof(struct _insertArgs));
		*insertArgs = (struct _insertArgs){
			.habit = habit,
			.bSelf = bSelf,
		};
		if((status = SH_addOp(appDel.dbQueue, _insertNewHabit, insertArgs, _cleanUpInsert)) != SH_NO_ERROR) { ; }
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


@end
