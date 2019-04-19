//
//  SHListItemCell.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHTaskCell.h"

@interface SHListItemCell : SHTaskCell
@property (weak, nonatomic) IBOutlet UILabel *lblRowDesc;
+(instancetype)getListItemCell:(UITableView *)tableView;
@end
