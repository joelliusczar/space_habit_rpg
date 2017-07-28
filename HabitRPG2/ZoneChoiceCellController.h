//
//  ZoneChoiceCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"
#import "ZoneChoiceViewController.h"
#import "Zone+CoreDataClass.h"

@interface ZoneChoiceCellController : TaskCell

@property (nonatomic,weak) IBOutlet UILabel *nameLbl;
@property (nonatomic,weak) IBOutlet UILabel *lvlLbl;
+(instancetype)getZoneChoiceCell:(UITableView *)tableView WithParent:(ZoneChoiceViewController *)parent
                        AndModel:(Zone *)model AndRow:(NSIndexPath *)rowInfo;
-(void)setupCell:(Zone *)model AndParent:(ZoneChoiceViewController *)parent
          AndRow:(NSIndexPath *)rowInfo;
@end
