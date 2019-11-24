//
//	SHDailyViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define dummyFlag 0 && defined(IS_DEV) && IS_DEV



#import "SHDailyViewController.h"
#import "SHEditNavigationController.h"
#import "SHDailyEditController.h"
#import "SHDailyCellController.h"
#import "SHIntroViewController.h"
@import SHGlobal;
@import SHCommon;
@import SHControls;
@import SHModels;
@import SHData;

#define shHoldUp(n) [NSThread sleepForTimeInterval:n]


@interface SHDailyViewController ()

@property (strong,nonatomic) SHDailyEditController *dailyEditor;
@property (strong,nonatomic) UITableView *dailiesTable;
@property (strong,nonatomic) NSFetchedResultsController *dailyItemsFetcher;
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) SHDaily_Medium *dailyMedium;
@property (strong,nonatomic) NSManagedObjectContext *dailyContext;

@end

@implementation SHDailyViewController

static NSString *const EntityName = @"Daily";

@synthesize dailyEditor = _dailyEditor;
-(SHDailyEditController *)dailyEditor{
	if(_dailyEditor == nil){
		_dailyEditor = [[SHDailyEditController alloc] init];
	}
	return _dailyEditor;
}


-(NSManagedObjectContext*)dailyContext{
	if(nil == _dailyContext){
		_dailyContext = [self.central.dataController newBackgroundContext];
	}
	return _dailyContext;
}


-(instancetype)initWithCentral:(SHCentralViewController *)central{
	if(self = [self initWithNibName:@"SHHabitViewController" bundle:nil]){
		_central = central;
		[self setuptab];
		
	}
	return self;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	self.dailiesTable = [[UITableView alloc] init];

	[self.view addSubview:self.dailiesTable];
	self.dailiesTable.translatesAutoresizingMaskIntoConstraints = NO;
	[self.dailiesTable.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
	[self.dailiesTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
	[self.dailiesTable.topAnchor constraintEqualToAnchor:self.addDailiesBtn.bottomAnchor].active = YES;
	self.dailiesTable.delegate = self;
	self.dailiesTable.dataSource = self;
	[self setupData];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(void)setuptab{
	UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle:@"Dailies"];
}


-(void)completeDaily:(SHDaily *)daily{
	daily.rollbackActivationDateTime = daily.lastActivationDateTime;
	daily.lastActivationDateTime = [[NSDate date] dayStart];
	//TODO: calculate damage done to monster
	//TODO: save
}


-(void)undoCompletedDaily:(SHDaily *)daily{
	daily.lastActivationDateTime = daily.rollbackActivationDateTime;
	//TODO: more stuff
}


-(void)setupData{
	SHDaily_Medium *dailyMedium = [SHDaily_Medium newWithContext:self.dailyContext];
	self.dailyItemsFetcher = [dailyMedium dailiesDataFetcher];
	self.dailyItemsFetcher.delegate = self;
	[self fetchUpdates];
}


-(void)fetchUpdates{
	[self.dailyContext performBlock:^{
		NSError *error = nil;
		if(![self.dailyItemsFetcher performFetch:&error]){
			@throw [NSException dbException:error];
		}
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.dailiesTable reloadData];
		}];
	}];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	(void)tableView;
	return self.dailyItemsFetcher.sections.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	(void)tableView;
	NSInteger rowCount = self.dailyItemsFetcher.sections[section].numberOfObjects;
	return rowCount;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	(void)tableView;
	if(self.dailyItemsFetcher.sections.count == 2) {
		if(section == SH_INCOMPLETE) {
			return @"Unfinished";
		}
		else {
			return @"Finished";
		}
	}
	else if(self.dailyItemsFetcher.sections.count == 1) {
		__block NSString *title = @"";
		[self.dailyItemsFetcher.managedObjectContext performBlockAndWait:^{
			if(self.dailyItemsFetcher.fetchedObjects.count < 1) return;
			SHDaily *daily = (SHDaily *)self.dailyItemsFetcher.fetchedObjects[0];
			title = daily.isCompleted ? @"Finished" : @"Unfinished";
		}];
		return title;
	}
	return @"";
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
	(void)controller;
	NSAssert(![NSThread isMainThread],@"this method should only be called from background");
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[self.dailiesTable beginUpdates];
	}];
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
	(void)controller;
	NSAssert(![NSThread isMainThread],@"this method should only be called from background");
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[self.dailiesTable endUpdates];
	}];
}


- (IBAction)addDailyBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	NSManagedObjectContext *context = [self.dailyContext createChildContext];
	SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc] initWithEntityType:SHDaily.entity
		withContext:context];
	[self setupEditorWithObjectIDWrapper:objectIDWrapper withContext:context];
	
	self.central.editController.editingScreen = self.dailyEditor;
	self.central.editController.title = @"Daily";
	self.central.editController.context = context;
	self.central.editController.objectIDWrapper = objectIDWrapper;
	[self.central arrangeAndPushChildVCToFront:self.central.editController];
}


-(void)swipeEditActionWithIndexPath:(NSIndexPath*)indexPath
	WithCompletionHandler:(void (^)(BOOL))completionHandler
{
	NSFetchedResultsController *fetchController = self.dailyItemsFetcher;
	NSManagedObjectContext *fetchContext = fetchController.managedObjectContext;
	[fetchContext performBlockAndWait:^{
		NSManagedObject *rowObject = fetchController.fetchedObjects[indexPath.row];
		SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc] init];
		objectIDWrapper.objectID = rowObject.objectID;
		objectIDWrapper.entityType = SHDaily.entity;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			NSManagedObjectContext *context = [self.dailyContext createChildContext];
			[self setupEditorWithObjectIDWrapper:objectIDWrapper
				withContext:context];
			self.central.editController.editingScreen = self.dailyEditor;
			self.central.editController.title = @"Daily";
			self.central.editController.context = context;
			self.central.editController.objectIDWrapper = objectIDWrapper;
			[self.central arrangeAndPushChildVCToFront:self.central.editController];
			completionHandler(YES);
		}];
	}];
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
					[self swipeEditActionWithIndexPath:indexPath WithCompletionHandler:completionHandler];
		}];
	UISwipeActionsConfiguration *actionConfigs = [UISwipeActionsConfiguration
		configurationWithActions:@[editAction]];
	
	return actionConfigs;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	SHDailyCellController *cell = [SHDailyCellController getDailyCell:tableView WithParent:self];
	__block NSManagedObjectID *objectID = nil;
	[self.dailyContext performBlockAndWait:^{
		objectID = ((SHDaily*)self.dailyItemsFetcher.sections[indexPath.section].objects[indexPath.row]).objectID;
	}];
	SHObjectIDWrapper *wrappedID = [[SHObjectIDWrapper alloc] initWithEntityType:SHDaily.entity
		withContext:self.dailyContext];
	wrappedID.objectID = objectID;
	[cell setupCell:wrappedID];
	return cell;
}


/*
This will be called the user creates a new daily, checks it off, or deletes one
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
				[self.dailiesTable insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeUpdate:
				[self configureCellAtIndexPath:indexPath];
				break;
			case NSFetchedResultsChangeDelete:
				[self.dailiesTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeMove:
				[self configureCellAtIndexPath:indexPath];
				[self.dailiesTable moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
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
				[self.dailiesTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
					withRowAnimation:UITableViewRowAnimationFade];
				break;
			case NSFetchedResultsChangeDelete:
				[self.dailiesTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
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
	UITableViewCell *cell = [self.dailiesTable cellForRowAtIndexPath:indexPath];
	SHDailyCellController *dailyCell = (SHDailyCellController *)cell;
	[dailyCell refreshCell];
}

-(void)setupEditorWithObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper
	withContext:(NSManagedObjectContext *)context
{
	NSManagedObjectContext *parentContext = self.dailyContext;
	__weak NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
	__weak SHDailyViewController *weakSelf = self;
	__block id token = [center addObserverForName:NSManagedObjectContextDidSaveNotification
		object:context
		queue:nil
		usingBlock:^(NSNotification *notfification){
			(void)notfification;
			[parentContext performBlock:^{
				NSError *error = nil;
				if(parentContext.hasChanges){
					[parentContext save:&error];
					if(error){
						[[NSOperationQueue mainQueue] addOperationWithBlock:^{
							SHDailyViewController *bSelf = weakSelf;
							if(nil == bSelf) return;
							[bSelf showErrorView:@"Save failed" withError:error];
						}];
					}
				}
			}];
			[center removeObserver:token];
		}];
	
	[self.dailyEditor setupForContext:context andObjectIDWrapper:objectIDWrapper];;
}


@end
