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



@interface SHSectorChoiceCellController : SHTaskCell

@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *lvlLbl;
@property (copy,nonatomic) void (^onSectorSelectionAction)(NSString*);
+(instancetype)getSectorChoiceCell:(UITableView *)tableView withParent:(SHSectorChoiceViewController *)parent
	withSector:(SHSector *)sector
	withRow:(NSIndexPath *)rowInfo;

-(void)setupCellWithSector:(SHSector *)sector withParent:(SHSectorChoiceViewController *)parent
	withRow:(NSIndexPath *)rowInfo;
@end
