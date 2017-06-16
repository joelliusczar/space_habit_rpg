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
@import CoreGraphics;



@interface DailyCellController()
@property (nonatomic,weak) Daily *model;
@property (nonatomic,weak) DailyViewController *parentDailyController;
//@property (nonatomic,weak) UIButton *completeBtn;
@property (weak,nonatomic) IBOutlet UILabel *daysLeftLbl;
@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *streakLbl;
@property (weak,nonatomic) IBOutlet UIButton *completeBtn;
@property (assign,nonatomic) NSInteger rowIndex;
@property (assign,nonatomic) NSInteger sectionIndex;

@end

@implementation DailyCellController

+(id)getDailyCell:(UITableView *)tableView WithParent:(DailyViewController *)parent{
    DailyCellController *cell = [DailyCellController getCell:tableView WithNibName:@"DailyCell" AndParent:parent];
    //I'm setting this up here because I need methods that are specifically on
    //the DailyViewController, and thus, I need the instance variable to be up here also.
    cell.parentDailyController = parent;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self completeBtn];  
}

-(void)setupCell:(Daily *)model AndRow:(NSIndexPath *)rowInfo{
    self.model = model;
    [self refreshCell:rowInfo];
    
}

-(void)refreshCell:(NSIndexPath *)rowInfo{
    self.rowIndex = rowInfo.row;
    self.sectionIndex = rowInfo.section;
    self.nameLbl.text = self.model.dailyName;
    if(self.model.streakLength > 0){
        self.streakLbl.hidden = NO;
        self.streakLbl.text = [NSString stringWithFormat:@"Streak: %d",self.model.streakLength];
    }
    else{
        self.streakLbl.hidden = YES;
    }
    if(self.model.rate > 1){
        self.daysLeftLbl.hidden = NO;
        self.daysLeftLbl.text = [NSString stringWithFormat:@"Days left: %d",[Daily getDaysLeft:self.model.nextDueTime]];
    }
    else{
        self.daysLeftLbl.hidden = YES;
    }
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
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@completeBtn_press_action~section:%ld~row:%ld",self.description,self.sectionIndex,self.rowIndex]];
}

@end
