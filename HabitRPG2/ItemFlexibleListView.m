//
//  ItemFlexibleListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ItemFlexibleListView.h"
#import "NSException+SHCommonExceptions.h"

@implementation ItemFlexibleListView

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    @throw [NSException abstractException];
}

-(UITableViewCell *)tableView:(UITableViewCell *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @throw [NSException abstractException];
}

-(void)addItemBtn_press_action:(UIButton *)sender
                      forEvent:(UIEvent *)event{
    @throw [NSException abstractException];
}




@end
