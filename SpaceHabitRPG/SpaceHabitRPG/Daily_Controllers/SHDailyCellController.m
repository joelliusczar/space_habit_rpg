//
//  SHDailyCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyCellController.h"
#import <SHModels/SHDaily.h>
#import <SHGlobal/SHConstants.h>
#import <SHCommon/SHInterceptor.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/SHSingletonCluster.h>
@import CoreGraphics;



@interface SHDailyCellController()
@property (nonatomic,weak) SHDailyDTO *model;
@property (nonatomic,weak) SHDailyViewController *parentDailyController;
@property (assign,nonatomic) NSInteger rowIndex;
@property (assign,nonatomic) NSInteger sectionIndex;

@end

@implementation SHDailyCellController

+(instancetype)getDailyCell:(UITableView *)tableView WithParent:(SHDailyViewController *)parent{
  SHDailyCellController *cell = [tableView
    dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
  if(nil==cell){
    cell = [[SHDailyCellController alloc] init];
  }
  cell.parentDailyController = parent;
  return cell;
}

- (void)awakeFromNib {
  [super awakeFromNib];
}

-(void)setupCell:(SHDailyDTO *)model AndRow:(NSIndexPath *)rowInfo{
    self.model = model;
    [self refreshCell:rowInfo];
}

-(void)refreshCell:(NSIndexPath *)rowInfo{
    self.rowIndex = rowInfo.row;
    self.sectionIndex = rowInfo.section;
    self.nameLbl.text = self.model.dailyName;
    
    //for current streak count
    if(self.model.streakLength > 0){
        self.streakLbl.hidden = NO;
        self.streakLbl.text = [NSString stringWithFormat:@"Combo: %d",self.model.streakLength];
    }
    else{
        self.streakLbl.hidden = YES;
    }
    //for due in x days
    if(self.model.rate > 1){
        self.daysLeftLbl.hidden = NO;
        self.daysLeftLbl.text = self.model.daysUntilDue==0?@"Today":
          [NSString stringWithFormat:@"Due in %lul days",self.model.daysUntilDue];
    }
    else{
        self.daysLeftLbl.hidden = YES;
    }
    //for check image
    if(self.sectionIndex == SH_INCOMPLETE){
        [self.completeBtn setImage:[UIImage imageNamed:@"unchecked_task"] forState:UIControlStateNormal];
    }
    else{
        [self.completeBtn setImage:[UIImage imageNamed:@"checked_task"] forState:UIControlStateNormal];
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)completeBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
        (void)sender;
        (void)event;
//        if(self.model.sectionNum == SH_INCOMPLETE){
//            self.model.sectionNum  = SH_COMPLETE;
//            [self.parentDailyController completeDaily:self.model];
//        }
//        else{
//            self.model.sectionNum  = SH_INCOMPLETE;
//            [self.parentDailyController undoCompletedDaily:self.model];
//        }
}

@end
