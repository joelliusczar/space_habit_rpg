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
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHModels/NSManagedObjectContext+SHModelHelper.h>
#import <SHModels/SHDailyActivator.h>
@import CoreGraphics;



@interface SHDailyCellController()
@property (strong,nonatomic) SHObjectIDWrapper *objectID;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (weak,nonatomic) SHDailyViewController *parentDailyController;
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

-(void)setupCell:(SHObjectIDWrapper *)objectID withContext:(NSManagedObjectContext*)context
  andRow:(NSIndexPath *)rowInfo
{
  self.context = context;
  self.objectID = objectID;
  [self refreshCell:rowInfo];
}

-(void)refreshCell:(NSIndexPath *)rowInfo{
  self.rowIndex = rowInfo.row;
  self.sectionIndex = rowInfo.section;
  [self.context performBlock:^{
    NSError *error = nil;
    SHDaily *daily = (SHDaily*)[self.context getEntityOrNil:self.objectID withError:&error];
    NSString *dailyName = daily.dailyName;
    int32_t streakLength = daily.streakLength;
    int32_t rate = daily.rate;
    NSUInteger daysUntilDue = daily.maxDaysBefore;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.nameLbl.text = dailyName;
        //for current streak count
      if(streakLength > 0){
        self.streakLbl.hidden = NO;
        self.streakLbl.text = [NSString stringWithFormat:@"Combo: %d",streakLength];
      }
      else{
        self.streakLbl.hidden = YES;
      }
      //for due in x days
      if(rate > 1){
        self.daysLeftLbl.hidden = NO;
        self.daysLeftLbl.text = daysUntilDue==0?@"Today":
          [NSString stringWithFormat:@"Due in %lul days",daysUntilDue];
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
    }];
  }];
  
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  // Configure the view for the selected state
}

-(IBAction)completeBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
  (void)sender; (void)event;
  SHDailyActivator *activator = [[SHDailyActivator alloc] initWithContext:self.context
    withObjectId:self.objectID];
  [activator activate];
  
}

@end
