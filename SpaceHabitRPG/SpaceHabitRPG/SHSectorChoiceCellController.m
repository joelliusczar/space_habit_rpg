//
//	SHSectorChoiceCellController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceCellController.h"
#import "SHSectorDescriptionViewController.h"
@import SHCommon;
@import SHControls;


@interface SHSectorChoiceCellController()
@property (weak, nonatomic) SHSectorChoiceViewController *parentSectorController;
@property (strong, nonatomic,) SHSector *sector;
@property (strong, nonatomic) NSIndexPath *rowInfo;
@property (strong, nonatomic) UISwipeGestureRecognizer *swiper;
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
	withSector:(SHSector *)sector
	withRow:(NSIndexPath *)rowInfo
{
	SHSectorChoiceCellController *cell = [tableView
		dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
	if(nil==cell){
		cell = [[SHSectorChoiceCellController alloc] init];
	}
	[cell setupCellWithSector:sector withParent:parent withRow:rowInfo];
	return cell;
}


-(void)setupCellWithSector:(SHSector *)sector withParent:(SHSectorChoiceViewController *)parent
	withRow:(NSIndexPath *)rowInfo
{
	self.parentSectorController = parent;

	NSString *sectorName = sector.fullName;
	NSString *lvlText = [NSString stringWithFormat:@"Lvl: %ld",sector.lvl];
	self.nameLbl.text = sectorName;
	self.lvlLbl.text = lvlText;
	self.rowInfo = rowInfo;
	[self addGestureRecognizer:self.swiper];
	[self.contentView checkForAndApplyVisualChanges];
}

-(void)awakeFromNib{
	[super awakeFromNib];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)swipe{
	if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
		SHSectorDescriptionViewController *descView = self.parentSectorController.descViewController;
		descView.sector = self.sector;
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
