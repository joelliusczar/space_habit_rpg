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


-(SHHabitNameViewController *)nameViewController {
	if(nil == _nameViewController) {
		_nameViewController = [[SHHabitNameViewController alloc] init];
	}
	return _nameViewController;
}


-(instancetype)initWithCentral:(SHCentralViewController *)central
	withContext:(NSManagedObjectContext*)context
{
	if(self = [self initWithNibName:@"SHHabitViewController" bundle:nil]){
		_central = central;
		_context = context;
		
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
	SHIconBuilder * iconBuilder = [[SHIconBuilder alloc] initWithColor:UIColor.whiteColor
		withBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:126.0/255.0 blue:217.0/255.0 alpha:1]
		withSize:CGSizeMake(50, 50)
		withThickness:5];
	UIImage *addHabitIcon = [iconBuilder drawPlus];
	[self.addHabitBtnIcon setImage:addHabitIcon];
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


-(void)openEditor:(SHObjectIDWrapper *)objectIDWrapper {
	NSManagedObjectContext *context = [objectIDWrapper.context createChildContext];
	[self setupEditorForSaving:objectIDWrapper withContext:context];
	
	SHEditNavigationController *editNavController = self.central.editController;
	editNavController.editingScreen = self.habitEditor;
	editNavController.title = self.entityName;
	editNavController.context = context;
	editNavController.objectIDWrapper = objectIDWrapper;
	[self.central arrangeAndPushChildVCToFront:self.central.editController];
}


-(void)swipeEditActionWithIndexPath:(NSIndexPath*)indexPath
	withCompletionHandler:(void (^)(BOOL))completionHandler
{
	NSFetchedResultsController *fetchController = self.habitItemsFetcher;
	NSManagedObjectContext *fetchContext = fetchController.managedObjectContext;
	[fetchContext performBlockAndWait:^{
		NSManagedObject *rowObject = fetchController.fetchedObjects[indexPath.row];
		SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc]
			initWithManagedObject:rowObject];
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self openEditor:objectIDWrapper];
			completionHandler(YES);
		}];
	}];
}


-(void)onAddHabitTap_action:(UIGestureRecognizer *)recognizer {
	(void)recognizer;
	__weak SHHabitViewController *weakSelf = self;
	self.nameViewController.onNext = ^(NSString *name){
		SHHabitViewController *bSelf = weakSelf;
		if(nil == bSelf) return;
		SHHabitNameViewController *nameVC = bSelf.nameViewController;
		[bSelf.context performBlock:^{
			NSManagedObject<SHTitleProtocol> *habit =
				(NSManagedObject<SHTitleProtocol>*)[bSelf.context newEntity:bSelf.entityType];
			habit.title = name;
			NSError *error = nil;
			[bSelf.context save:&error];
			SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc]
				initWithManagedObject:habit];
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				if(error) {
					[bSelf showErrorView:@"Save failed" withError:error];
				}
				[nameVC popVCFromFront];
				[bSelf openEditor: objectIDWrapper];
				if(bSelf.onOpenAddHabit) {
					bSelf.onOpenAddHabit();
				}
			}];
		}];
	};
	self.nameViewController.headline.text = self.entityName;
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


-(void)setupEditorForSaving:(SHObjectIDWrapper*)objectIDWrapper
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
