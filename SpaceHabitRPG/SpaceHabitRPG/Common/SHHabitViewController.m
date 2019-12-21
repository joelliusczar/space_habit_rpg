//
//  SHHabitViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHabitViewController.h"
@import SHCommon;


@interface SHHabitViewController ()
@property (strong, nonatomic) UITableView *habitTable;
@property (weak, nonatomic) IBOutlet SHView *addHabitBtn;
@end

@implementation SHHabitViewController


-(SHViewController<SHEditingSaverProtocol> *)habitEditor {
	@throw [NSException abstractException];
}


-(void)setHabitEditor:(SHViewController<SHEditingSaverProtocol> *)habitEditor {
	(void)habitEditor;
	@throw [NSException abstractException];
}


-(NSEntityDescription*)entityType {
	@throw [NSException abstractException];
}


-(NSString*)entityName {
	@throw [NSException abstractException];
}


-(instancetype)initWithCentral:(SHCentralViewController *)central
	withContext:(NSManagedObjectContext*)context
{
	if(self = [self initWithNibName:@"SHHabitViewController" bundle:nil]){
		_central = central;
		_context = context;
		[self setuptab];
		
	}
	return self;
}


-(void)setuptab{
	@throw [NSException abstractException];
}


-(void)viewDidLoad {
	[super viewDidLoad];
	self.habitTable = [[UITableView alloc] init];

	[self.view addSubview:self.habitTable];
	self.habitTable.translatesAutoresizingMaskIntoConstraints = NO;
	[self.habitTable.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
	[self.habitTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
	[self.habitTable.topAnchor constraintEqualToAnchor:self.habitTable.bottomAnchor].active = YES;
	self.habitTable.delegate = self;
	self.habitTable.dataSource = self;
	self.addHabitBtn.eventDelegate = self;
	[self setupData];
}


-(void)setupData {
	@throw [NSException abstractException];
}


-(void)fetchUpdates{
	[self.context performBlock:^{
		NSError *error = nil;
		if(![self.habitItemsFetcher performFetch:&error]){
			@throw [NSException dbException:error];
		}
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.habitTable reloadData];
		}];
	}];
}


-(nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
	cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
		SHHabitCell *cell = [self getTableCell:tableView];
	__block NSManagedObjectID *objectID = nil;
	[self.context performBlockAndWait:^{
		NSManagedObject *mananagedObject = (NSManagedObject*)self.habitItemsFetcher
			.sections[indexPath.section]
			.objects[indexPath.row];
		objectID = mananagedObject.objectID;
	}];
	SHObjectIDWrapper *wrappedID = [[SHObjectIDWrapper alloc]
		initWithEntityType:self.entityType
		withContext:self.context];
	wrappedID.objectID = objectID;
	[cell setupCell:wrappedID];
	return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	(void)tableView;
	return self.habitItemsFetcher.sections.count;
}


-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	(void)tableView;
	NSInteger rowCount = self.habitItemsFetcher.sections[section].numberOfObjects;
	return rowCount;
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


-(void)openEditor {
	NSManagedObjectContext *context = [self.context createChildContext];
	SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc]
		initWithEntityType:self.entityType
		withContext:context];
	[self setupEditorWithObjectIDWrapper:objectIDWrapper withContext:context];
	
	self.central.editController.editingScreen = self.habitEditor;
	self.central.editController.title = self.entityName;
	self.central.editController.context = context;
	self.central.editController.objectIDWrapper = objectIDWrapper;
	[self.central arrangeAndPushChildVCToFront:self.central.editController];
}


-(void)swipeEditActionWithIndexPath:(NSIndexPath*)indexPath
	withCompletionHandler:(void (^)(BOOL))completionHandler
{
	NSFetchedResultsController *fetchController = self.habitItemsFetcher;
	NSManagedObjectContext *fetchContext = fetchController.managedObjectContext;
	[fetchContext performBlockAndWait:^{
		NSManagedObject *rowObject = fetchController.fetchedObjects[indexPath.row];
		SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc] init];
		objectIDWrapper.objectID = rowObject.objectID;
		objectIDWrapper.entityType = self.entityType;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			NSManagedObjectContext *context = [self.context createChildContext];
			[self setupEditorWithObjectIDWrapper:objectIDWrapper
				withContext:context];
			self.central.editController.editingScreen = self.habitEditor;
			self.central.editController.title = self.entityName;
			self.central.editController.context = context;
			self.central.editController.objectIDWrapper = objectIDWrapper;
			[self.central arrangeAndPushChildVCToFront:self.central.editController];
			completionHandler(YES);
		}];
	}];
}


-(void)onBeginTap_action:(SHView *)sender withEvent:(UIEvent*)event {
	(void)sender; (void)event;
	[self openEditor];
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


-(void)setupEditorWithObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper
	withContext:(NSManagedObjectContext *)context
{
	NSManagedObjectContext *parentContext = self.context;
	__weak NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
	__weak SHHabitViewController *weakSelf = self;
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
							SHHabitViewController *bSelf = weakSelf;
							if(nil == bSelf) return;
							[bSelf showErrorView:@"Save failed" withError:error];
						}];
					}
				}
			}];
			[center removeObserver:token];
		}];
	
	[self.habitEditor setupForContext:context andObjectIDWrapper:objectIDWrapper];
}


-(SHTaskCell *)getTableCell:(UITableView*)tableView {
	(void)tableView;
	@throw [NSException abstractException];
}

@end
