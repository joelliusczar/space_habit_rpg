//
//  ZoneChoiceCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHControls/SHTaskCell.h>
#import <SHModels/SHSector+CoreDataClass.h>
#import <SHModels/SHSectorDTO.h>
#import "ZoneChoiceViewController.h"



@interface ZoneChoiceCellController : SHTaskCell

@property (nonatomic,weak) IBOutlet UILabel *nameLbl;
@property (nonatomic,weak) IBOutlet UILabel *lvlLbl;
+(instancetype)getZoneChoiceCell:(UITableView *)tableView WithParent:(ZoneChoiceViewController *)parent
                        AndModel:(SHSectorDTO *)model AndRow:(NSIndexPath *)rowInfo;
-(void)setupCell:(SHSectorDTO *)model AndParent:(ZoneChoiceViewController *)parent
          AndRow:(NSIndexPath *)rowInfo;
@end
