//
//  SHItemFlexibleListEventInfo.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@class SHItemFlexibleListView;

#import "SHEventInfo.h"
#import "SHItemFlexibleListView.h"



@interface SHItemFlexibleListEventInfo : SHEventInfo
@property (readonly,strong,nonatomic) NSIndexPath *indexPath;
@property (readonly,strong,nonatomic) UITableView *tableView;
@property (readonly,strong,nonatomic) SHItemFlexibleListView *itemFlexibleListView;
-(instancetype)initWithItemFlexibleList:(SHItemFlexibleListView *)itemFlexibleList
                           andIndexPath:(NSIndexPath *)indexPath;
@end
