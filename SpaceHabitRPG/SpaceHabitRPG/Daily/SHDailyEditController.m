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
@property (assign,nonatomic) shDailyStatus section;
@property (assign,nonatomic) BOOL isStreakReset;
@property (strong,nonatomic) NSMutableArray<SHViewController *> *editControls;
@property (assign,nonatomic) BOOL isEditingExisting;
@end

@implementation SHDailyEditController

//These need to be synthesized since they come from a protocol
@synthesize editorContainerController = _editorContainerController;
@synthesize nameStr = _nameStr;
@synthesize controlsTbl = _controlsTbl;
@synthesize context = _context;


-(UITextField *)nameBox {
	return self.editorContainerController.itemNameInput;
}


-(instancetype)init{
	if(self = [super init]){
		_controlsTbl = [[UITableView alloc] init];
	}
	return self;
}


-(void)setupForContext:(NSManagedObjectContext*)context
	andObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper
{
	self.context = context;
	self.objectIDWrapper = objectIDWrapper;
	__block SHDailyActiveDays *activeDays = nil;
	[context performBlockAndWait:^{
		SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		activeDays = daily.activeDaysContainer;
	}];
	self.activeDays = activeDays;
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
	
	self.editControls = [self buildControlKeep];
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
	[self.context performBlock:^{
		SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		daily.streakLength = 0;
	}];
}


-(void)saveEdit{
	NSManagedObjectContext *context = self.context;
	NSString *updatedActiveDays = [self.activeDays activeDaysAsJson];
	[context performBlock:^{
		SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		daily.activeDays = updatedActiveDays;
		NSError *error = nil;
		if(!context.hasChanges) return;
		[context save:&error];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			if(error){
				[self showErrorView:@"Save failed" withError:error];
			}
		}];
	}];
}


-(void)deleteModel{
	NSManagedObjectID *objectID = self.objectIDWrapper.objectID;
	if(objectID){
		NSManagedObjectContext *context = self.context;
		[context performBlock:^{
			NSError *error = nil;
			NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithObjectIDs:@[objectID]];
			[context executeRequest:deleteRequest error:&error];
			if(error){
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					[self showErrorView:@"Delete failed" withError:error];
				}];
			}
		}];
	}
}


-(void)afterloadFinishSetup{
	if(self.objectIDWrapper.objectID){
		[self.context performBlock:^{
			SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
			NSString *dailyName = daily.dailyName;
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				self.nameBox.text = dailyName;
				
			}];
		}];
	}
}


-(void)textDidChange:(SHNoteView *)sender{
	NSString *note = sender.noteBox.text;
	[self.context performBlock:^{
		SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		daily.note = note;
	}];
}


-(void)sld_valueChanged_action:(SHImportanceSliderView *)sender{
	int32_t sliderValue = shCheckImportanceRange((int32_t)sender.importanceSld.value);
	[sender updateImportanceSlider:sliderValue];
	BOOL isUrgency = [sender.controlName isEqualToString:@"urgency"];
	[self.context performBlock:^{
		SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		if(isUrgency){
			daily.urgency = sliderValue;
		}
		else{
			daily.difficulty = sliderValue;
		}
	}];
}


@end
