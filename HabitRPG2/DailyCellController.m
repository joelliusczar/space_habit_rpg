//
//  DailyCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyCellController.h"
#import "Daily.h"
@import CoreGraphics;



@interface DailyCellController()
@property (nonatomic,weak) Daily *model;
@end

@implementation DailyCellController



@synthesize nameLbl = _nameLbl;
-(UILabel *)nameLbl{
    if(_nameLbl == nil){
        _nameLbl = [self.contentView viewWithTag:1];
    }
    return _nameLbl;
}

+(id)getDailyCell:(UITableView *)tableView WithParent:(id)parent{
    DailyCellController * cell = [DailyCellController getCell:tableView WithNibName:@"DailyCell" AndParent:parent];
    
    return cell;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awake");
    
    
}

-(void)a{
    NSLog(@"%f",(self.streakLbl.frame.origin.x + self.streakLbl.frame.size.width));
}

-(void)setupModel:(Daily *)model{
    self.model = model;
    self.nameLbl.text = self.model.dailyName;
    self.streakLbl.text = @"Streak: 3";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end
