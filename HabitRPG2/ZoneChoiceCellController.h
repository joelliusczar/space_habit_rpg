//
//  ZoneChoiceCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"
#import "ZoneChoice.h"
#import "Zone+CoreDataClass.h"

@interface ZoneChoiceCellController : TaskCell

@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UILabel *lvlLbl;

+(instancetype)getZoneChoiceCell:(UITableView *)tableView WithOwner:(ZoneChoice *)owner
                        AndModel:(Zone *)model AndRow:(NSIndexPath *)rowInfo;

@end
