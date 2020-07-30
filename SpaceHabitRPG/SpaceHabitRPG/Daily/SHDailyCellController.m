//
//	SHDailyCellController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/1/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyCellController.h"
#import "AppDelegate.h"
@import SHModels;
@import SHDatetime;
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
	struct SHTableDaily *tableDaily = (struct SHTableDaily *)self.tableHabit;
	NSString *dailyName = [NSString stringWithUTF8String:tableDaily->name];
	NSInteger streakLength = tableDaily->streakLength;
	AppDelegate *appDel = (AppDelegate*)UIApplication.sharedApplication.delegate;
	const struct SHDatetimeProvider *dateProvider = appDel.dateProvider;
	int64_t daysUntilDue = LONG_MAX;
	struct SHDatetime *todayStart = dateProvider->getUserTodayStart();
	if((SH_dateDiffDays(todayStart, tableDaily->nextDueDate, &daysUntilDue)) != SH_NO_ERROR) {}
	
	self.nameLbl.text = dailyName;
	if(streakLength > 0){
		self.streakLbl.hidden = NO;
		self.streakLbl.text = [NSString stringWithFormat:@"Combo: %ld",streakLength];
	}
	else {
		self.streakLbl.hidden = YES;
	}
	
	if(tableDaily->dueStatus == SH_IS_NOT_DUE) {
		self.completeBtn.enabled = NO;
		self.daysLeftLbl.hidden = NO;
		self.daysLeftLbl.text = daysUntilDue == 1 ? @"Due tomorrow" :
		[NSString stringWithFormat:@"Due in %llul days", daysUntilDue];
		[self.completeBtn setImage:[self drawCompletionIcon:1] forState:UIControlStateNormal];
	}
	else if(tableDaily->dueStatus == SH_IS_COMPLETED) {
		self.daysLeftLbl.hidden = YES;
		[self.completeBtn setImage:[self drawCompletionIcon:1] forState:UIControlStateNormal];
	}
	else if(tableDaily->dueStatus == SH_IS_DUE) {
		self.completeBtn.enabled = YES;
		[self.completeBtn setImage:[self drawCompletionIcon:0] forState:UIControlStateNormal];
	}
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	// Configure the view for the selected state
}

-(IBAction)completeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_daily_activate(self.dbQueue, (struct SHTableDaily*)self.tableHabit,
		self.tableChangeActions)) != SH_NO_ERROR)
	{
		//@throw [NSException ];
	}
//	SHDailyActivator *activator = [[SHDailyActivator alloc] initWithObjectId:self.objectID];
//	[activator activate];
}

@end
