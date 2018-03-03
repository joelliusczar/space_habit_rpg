//
//  ItemFlexibleListEventInfo.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@class ItemFlexibleListView;

#import "SHEventInfo.h"
#import "ItemFlexibleListView.h"



@interface ItemFlexibleListEventInfo : SHEventInfo
@property (readonly,strong,nonatomic) NSIndexPath *indexPath;
@property (readonly,strong,nonatomic) UITableView *tableView;
@property (readonly,strong,nonatomic) ItemFlexibleListView *itemFlexibleListView;
-(instancetype)initWithItemFlexibleList:(ItemFlexibleListView *)itemFlexibleList
                           andIndexPath:(NSIndexPath *)indexPath;
@end
