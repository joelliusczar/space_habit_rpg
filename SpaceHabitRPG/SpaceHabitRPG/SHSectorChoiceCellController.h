//
//	SHSectorChoiceCellController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceViewController.h"
@import SHControls;
@import SHModels;
@import SHData;


@interface SHSectorChoiceCellController : SHTaskCell

@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *lvlLbl;
@property (copy,nonatomic) void (^onSectorSelectionAction)(NSString*);
+(instancetype)getSectorChoiceCell:(UITableView *)tableView withParent:(SHSectorChoiceViewController *)parent
	withObjectID:(SHStoryItemObjectID *)objectID
	withRow:(NSIndexPath *)rowInfo;

-(void)setupCellWithObjectID:(SHStoryItemObjectID *)objectID withParent:(SHSectorChoiceViewController *)parent
	withRow:(NSIndexPath *)rowInfo;
@end
