//
//  DailyCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyCellController.h"
#import "DailyViewController.h"
#import "Daily+CoreDataClass.h"
#import "constants.h"
@import CoreGraphics;



@interface DailyCellController()
@property (nonatomic,weak) Daily *model;
@property (nonatomic,weak) DailyViewController *parentDailyController;
@property (nonatomic,weak) UIButton *completeBtn;

@end

@implementation DailyCellController



@synthesize nameLbl = _nameLbl;
-(UILabel *)nameLbl{
    if(_nameLbl == nil){
        _nameLbl = [self.contentView viewWithTag:1];
    }
    return _nameLbl;
}

@synthesize streakLbl = _streakLbl;
-(UILabel *)streakLbl{
    if(_streakLbl == nil){
        _streakLbl = [self.contentView viewWithTag:2];
    }
    return _streakLbl;
}

@synthesize completeBtn = _completeBtn;
-(UIButton *)completeBtn{
    if(_completeBtn == nil){
        _completeBtn = [self.contentView viewWithTag:5];
        [_completeBtn addTarget:self action:@selector(completionBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _completeBtn;
}

+(id)getDailyCell:(UITableView *)tableView WithParent:(id)parent{
    DailyCellController * cell = [DailyCellController getCell:tableView WithNibName:@"DailyCell" AndParent:parent];
    cell.parentDailyController = parent;
    return cell;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    [self completeBtn];
    
    
}


-(void)setupCell:(Daily *)model AndRow:(NSIndexPath *)rowInfo{
    self.model = model;
    self.nameLbl.text = self.model.dailyName;
    self.streakLbl.text = @"Streak: 3"; //TODO: make this dynamic
    //todo fix labels
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)completionBtnPress:(id)sender{
    if(self.model.sectionNum == INCOMPLETE){
        self.model.sectionNum  = COMPLETE;
        [self.completeBtn setImage:[UIImage imageNamed:@"checked_task.png"] forState:UIControlStateNormal];
        [self.parentDailyController completeDaily:self.model];
    }
    else{
        self.model.sectionNum  = INCOMPLETE;
        [self.completeBtn setImage:[UIImage imageNamed:@"unchecked_task.png"] forState:UIControlStateNormal];
        [self.parentDailyController undoCompletedDaily:self.model];
    }
}








@end
