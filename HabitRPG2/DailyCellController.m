//
//  DailyCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyCellController.h"
#import "Daily.h"

@interface DailyCellController()

@end

@implementation DailyCellController


- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLbl = (UILabel *)[self.contentView viewWithTag:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end
