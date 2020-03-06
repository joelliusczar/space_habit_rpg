//
//	SHDailyCellController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/1/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyCellController.h"
@import SHModels;

@import SHCommon;
@import CoreGraphics;



@interface SHDailyCellController()

@end

@implementation SHDailyCellController


- (void)awakeFromNib {
	[super awakeFromNib];
}


-(void)refreshCell{
	[self.context performBlock:^{
		NSError *error = nil;
		SHDaily *daily = (SHDaily*)[self.context getEntityOrNil:self.objectID withError:&error];
		NSString *dailyName = daily.dailyName;
		NSInteger streakLength = daily.streakLength;
		NSInteger rate = daily.rate;
		NSUInteger daysUntilDue = daily.daysUntilDue;
		BOOL isCompleted = daily.isCompleted;
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.nameLbl.text = dailyName;
				//for current streak count
			if(streakLength > 0){
				self.streakLbl.hidden = NO;
				self.streakLbl.text = [NSString stringWithFormat:@"Combo: %ld",streakLength];
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
			if(isCompleted){
				[self.completeBtn setImage:[UIImage imageNamed:@"checked_task"] forState:UIControlStateNormal];
			}
			else{
				[self.completeBtn setImage:[UIImage imageNamed:@"unchecked_task"] forState:UIControlStateNormal];
			}
		}];
	}];
	
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	// Configure the view for the selected state
}

-(IBAction)completeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	SHDailyActivator *activator = [[SHDailyActivator alloc] initWithContext:self.context
		withObjectId:self.objectID];
	[activator activate];
	
}

@end
