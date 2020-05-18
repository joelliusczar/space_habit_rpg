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


-(UIImage *)drawCompletionIcon:(CGFloat)percentDone {
	SHIconBuilder * builder = [[SHIconBuilder alloc] init];
	CGSize buttonSize = self.completeBtn.bounds.size;
	builder.size = CGSizeMake(buttonSize.width, buttonSize.height);
	builder.color = self.foreColor;
	builder.backgroundColor = self.backgroundColor;
	builder.tertiaryColor = self.completionColor;
	UIImage *img = [builder drawPie:percentDone];
	return img;
}


-(void)refreshCell{
	[self.context performBlock:^{
		NSError *error = nil;
		SHDaily *daily = (SHDaily*)[self.context getEntityOrNil:self.objectID withError:&error];
		NSString *dailyName = daily.dailyName;
		NSInteger streakLength = daily.streakLength;
		NSInteger rate = daily.intervalSize;
		NSUInteger daysUntilDue = daily.daysUntilDue;
		SHIntervalType rateType = (SHIntervalType)daily.intervalType;
		SHDailyStatus status = (SHDailyStatus)daily.status;
		
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
			
			if(status == SH_DAILY_STATUS_DUE) {
				self.completeBtn.hidden = NO;
				self.completeBtn.enabled = YES;
				[self.completeBtn setImage:[self drawCompletionIcon:0] forState:UIControlStateNormal];
			}
			else if(status == SH_DAILY_STATUS_COMPLETE){
				self.daysLeftLbl.hidden = YES;
				[self.completeBtn setImage:[self drawCompletionIcon:1] forState:UIControlStateNormal];
			}
			else if(status == SH_DAILY_STATUS_NOT_DUE) {
				self.completeBtn.hidden = YES;
				self.completeBtn.enabled = NO;
				self.daysLeftLbl.hidden = NO;
				self.daysLeftLbl.text = daysUntilDue == 1 ? @"Due tomorrow" :
					[NSString stringWithFormat:@"Due in %lul days", daysUntilDue];
			}
			else {
				@throw [NSException oddException:@"Either status was not correctly set"];
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
	SHDailyActivator *activator = [[SHDailyActivator alloc] initWithObjectId:self.objectID];
	[activator activate];
}

@end