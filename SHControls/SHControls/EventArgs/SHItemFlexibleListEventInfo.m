//
//  SHItemFlexibleListEventInfo.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHItemFlexibleListEventInfo.h"

@implementation SHItemFlexibleListEventInfo


-(instancetype)initWithItemFlexibleList:(SHItemFlexibleListView *)itemFlexibleList
    andIndexPath:(NSIndexPath *)indexPath
{
	if(self = [super init:nil withSenders:itemFlexibleList.itemTbl,itemFlexibleList,nil]){
		_indexPath = indexPath;
		_tableView = itemFlexibleList.itemTbl;
		_itemFlexibleListView = itemFlexibleList;
	}
	return self;
}


-(void)dealloc{
	_indexPath = nil;
	_tableView = nil;
	_itemFlexibleListView = nil;
	
}

@end
