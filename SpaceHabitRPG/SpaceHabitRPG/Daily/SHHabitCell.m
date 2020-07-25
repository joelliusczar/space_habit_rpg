//
//  SHHabitCell.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHabitCell.h"

@interface SHHabitCell ()

@end

@implementation SHHabitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setupCell:(struct SHTableHabit *)tableHabit{
	self.tableHabit = tableHabit;
	[self refreshCell];
}

@end
