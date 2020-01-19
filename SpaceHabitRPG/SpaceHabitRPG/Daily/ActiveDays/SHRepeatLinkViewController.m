//
//	SHRepeatLinkViewController.m
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 6/22/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRepeatLinkViewController.h"
#import "SHRateSelectionViewController.h"
@import SHControls;

@import SHModels;
@import SHCommon;


@interface SHRepeatLinkViewController ()
@property (strong,nonatomic) SHRateSelectionViewController *rateSelectionViewContoller;
@end

@implementation SHRepeatLinkViewController


-(SHRateSelectionViewController*)rateSelectionViewContoller{
	if(nil == _rateSelectionViewContoller){
		_rateSelectionViewContoller = [SHRateSelectionViewController newWithDefaultNib];
	}
	return _rateSelectionViewContoller;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	self.primaryLabel.text = @"Interval: ";
	NSString *desc = [self getIntervalDescription:self.rateType];
	self.descriptionLabel.text = desc;
}


-(NSString*)getIntervalDescription:(SHRateType)rateType {
	SHRateType useRateType = shExtractBaseRateType(rateType);
	NSString *desc = nil;
	switch (useRateType) {
		case SH_DAILY_RATE:
			return nil;
		case SH_WEEKLY_RATE:
			desc = [NSString stringWithFormat:@"%@ for\n%@",
				self.activeDays.weeklyActiveDays.intervalDescription,
				self.activeDays.weeklyActiveDays.weekDescription];
			return desc;
		case SH_MONTHLY_RATE:
			return nil;
		case SH_YEARLY_RATE:
			return nil;
		default:
			@throw [NSException oddException];
	}
}


-(void)openNextScreen{
	NSAssert(self.context,@"You forgot to call setupWithContext:andObjectID:");
	NSAssert(self.activeDays,@"You forgot to assign activeDays");
	[self.context performBlock:^{
		SHDaily *daily = (SHDaily *)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		SHRateType rateType = (SHRateType)daily.rateType;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.rateSelectionViewContoller selectRateType:rateType];
			self.rateSelectionViewContoller.activeDays = self.activeDays;
			__weak SHRepeatLinkViewController *weakSelf = self;
			self.rateSelectionViewContoller.onCloseIntervalSelect = ^(SHDailyActiveDays *activeDays) {
				(void)activeDays;
				SHRepeatLinkViewController *bSelf = weakSelf;
				if(nil == bSelf) return;
				NSString *desc = [bSelf getIntervalDescription:bSelf.rateType];
				bSelf.descriptionLabel.text = desc;
			};
			[self.editorContainer
				arrangeAndPushChildVCToFront:self.rateSelectionViewContoller];
		}];
	}];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
		// Get the new view controller using [segue destinationViewController].
		// Pass the selected object to the new view controller.
}
*/

@end
