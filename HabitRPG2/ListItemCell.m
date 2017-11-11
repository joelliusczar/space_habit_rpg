//
//  ListItemCell.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "ListItemCell.h"
#import "NSObject+Helper.h"

@implementation ListItemCell

+(instancetype)getListItemCell:(UITableView *)tableView{
    NSAssert(tableView,@"tableview is nil");
    ListItemCell *cell = [tableView
            dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
        cell = [[ListItemCell alloc] init];
    }
    return cell;
}

-(UIView *)loadDefaultXib{
    return [self loadXib:@"ListItemCell"];
}

- (IBAction)addReminderBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
}

@end
