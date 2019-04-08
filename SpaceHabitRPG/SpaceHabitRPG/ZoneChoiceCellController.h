//
//  ZoneChoiceCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHControls/TaskCell.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/SHZoneDTO.h>
#import "ZoneChoiceViewController.h"



@interface ZoneChoiceCellController : TaskCell

@property (nonatomic,weak) IBOutlet UILabel *nameLbl;
@property (nonatomic,weak) IBOutlet UILabel *lvlLbl;
+(instancetype)getZoneChoiceCell:(UITableView *)tableView WithParent:(ZoneChoiceViewController *)parent
                        AndModel:(ZoneDTO *)model AndRow:(NSIndexPath *)rowInfo;
-(void)setupCell:(ZoneDTO *)model AndParent:(ZoneChoiceViewController *)parent
          AndRow:(NSIndexPath *)rowInfo;
@end
