//
//  SHListItemCell.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHListItemCell.h"
#import <SHCommon/NSObject+Helper.h>

@implementation SHListItemCell

+(instancetype)getListItemCell:(UITableView *)tableView{
    NSAssert(tableView,@"tableview is nil");
    SHListItemCell *cell = [tableView
            dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
        cell = [[SHListItemCell alloc] init];
    }
    return cell;
}

-(UIView *)loadDefaultXib{
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"ListItemCell")];
    return [bundle loadNibNamed:@"ListItemCell" owner:self options:nil][0];
}

- (IBAction)addReminderBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
}

@end
