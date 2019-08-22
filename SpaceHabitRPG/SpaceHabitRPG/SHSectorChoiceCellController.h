//
//	SHSectorChoiceCellController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHControls/SHTaskCell.h>
#import <SHModels/SHSector.h>
#import <SHModels/SHSectorDTO.h>
#import "SHSectorChoiceViewController.h"



@interface SHSectorChoiceCellController : SHTaskCell

@property (nonatomic,weak) IBOutlet UILabel *nameLbl;
@property (nonatomic,weak) IBOutlet UILabel *lvlLbl;

+(instancetype)getSectorChoiceCell:(UITableView *)tableView WithParent:(SHSectorChoiceViewController *)parent
	AndModel:(SHSectorDTO *)model
	AndRow:(NSIndexPath *)rowInfo;

-(void)setupCell:(SHSectorDTO *)model AndParent:(SHSectorChoiceViewController *)parent
	AndRow:(NSIndexPath *)rowInfo;
@end
