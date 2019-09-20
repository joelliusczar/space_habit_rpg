//
//	SHSectorChoiceCellController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceCellController.h"
#import "SHSectorDescriptionViewController.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHCommonUtils.h>
#import <SHControls/UIView+Helpers.h>

@interface SHSectorChoiceCellController()
@property (nonatomic,weak) SHSectorChoiceViewController *parentSectorController;
@property (nonatomic,strong) SHStoryItemObjectID *objectID;
@property (nonatomic,strong) NSIndexPath *rowInfo;
@property (nonatomic,strong) UISwipeGestureRecognizer *swiper;
@end

@implementation SHSectorChoiceCellController


-(UISwipeGestureRecognizer *)swiper{
	if(!_swiper){
		_swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
		_swiper.direction = UISwipeGestureRecognizerDirectionLeft;
	}
	return _swiper;
}


+(instancetype)getSectorChoiceCell:(UITableView *)tableView withParent:(SHSectorChoiceViewController *)parent
	withObjectID:(SHStoryItemObjectID *)objectID
	withRow:(NSIndexPath *)rowInfo
{
	SHSectorChoiceCellController *cell = [tableView
		dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
	if(nil==cell){
		cell = [[SHSectorChoiceCellController alloc] init];
	}
	[cell setupCellWithObjectID:objectID withParent:parent withRow:rowInfo];
	return cell;
}


-(void)setupCellWithObjectID:(SHStoryItemObjectID *)objectID withParent:(SHSectorChoiceViewController *)parent
	withRow:(NSIndexPath *)rowInfo
{
	self.parentSectorController = parent;
	self.objectID = objectID;
	[objectID.context performBlock:^{
		NSError *err = nil;
		SHSector *sector = (SHSector *)[objectID.context getEntityOrNil:objectID withError:&err];
		if(err){
			return;
		}
		NSString *sectorName = sector.fullName;
		NSString *lvlText = [NSString stringWithFormat:@"Lvl: %d",sector.lvl];
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.nameLbl.text = sectorName;
			self.lvlLbl.text = lvlText;
			self.rowInfo = rowInfo;
			[self addGestureRecognizer:self.swiper];
			[self.contentView checkForAndApplyVisualChanges];
		}];
	}];
}

-(void)awakeFromNib{
	[super awakeFromNib];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)swipe{
	if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
		SHSectorDescriptionViewController *descView = self.parentSectorController.descViewController;
		descView.storyItemObjectID = self.objectID;
		[self.parentSectorController arrangeAndPushChildVCToFront:descView];
	}
	else{
		NSLog(@"%@",@"wrong");
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	// Drawing code
}
*/

@end
