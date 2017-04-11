//
//  TaskCell.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"


@interface TaskCell()
@property (nonatomic,strong) UIButton *editButton;
@end

@implementation TaskCell



+(id)getCell:(UITableView *)tableView WithNibName:(NSString *)nibName AndParent:(id)parent{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:parent options:nil];
        cell = nib[0];
    }

    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
