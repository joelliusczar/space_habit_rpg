//
//  DailyCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyCellController.h"
#import "Daily+CoreDataClass.h"
#import "Daily+DailyHelper.h"
#import "constants.h"
#import "Interceptor.h"
#import "NSDate+DateHelper.h"
#import "SingletonCluster.h"
@import CoreGraphics;



@interface DailyCellController()
@property (nonatomic,weak) Daily *model;
@property (nonatomic,weak) DailyViewController *parentDailyController;
@property (assign,nonatomic) NSInteger rowIndex;
@property (assign,nonatomic) NSInteger sectionIndex;

@end

@implementation DailyCellController

+(instancetype)getDailyCell:(UITableView *)tableView WithParent:(DailyViewController *)parent{
    DailyCellController *cell = [tableView
                                 dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
        cell = [[DailyCellController alloc] init];
    }
    cell.parentDailyController = parent;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setupCell:(Daily *)model AndRow:(NSIndexPath *)rowInfo{
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
        self.daysLeftLbl.text = self.model.daysUntilDue==0?@"Today":[NSString stringWithFormat:@"Due in %d days",self.model.daysUntilDue];
    }
    else{
        self.daysLeftLbl.hidden = YES;
    }
    //for check image
    if(self.sectionIndex == INCOMPLETE){
        [self.completeBtn setImage:[UIImage imageNamed:@"unchecked_task.png"] forState:UIControlStateNormal];
    }
    else{
        [self.completeBtn setImage:[UIImage imageNamed:@"checked_task.png"] forState:UIControlStateNormal];
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)completeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        if(self.model.sectionNum == INCOMPLETE){
            self.model.sectionNum  = COMPLETE;
            [self.parentDailyController completeDaily:self.model];
        }
        else{
            self.model.sectionNum  = INCOMPLETE;
            [self.parentDailyController undoCompletedDaily:self.model];
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
