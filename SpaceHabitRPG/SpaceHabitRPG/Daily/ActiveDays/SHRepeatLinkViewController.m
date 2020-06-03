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


-(void)viewDidLoad {
	[super viewDidLoad];
	char *activeDaysDesc = SH_selectIntervalDescription(self.activeDays);
	self.primaryLabel.text = @"Interval: ";
	self.descriptionLabel.text = [NSString stringWithUTF8String:activeDaysDesc];
	free(activeDaysDesc);

}


-(void)openNextScreen{
	NSAssert(self.activeDays,@"You forgot to assign activeDays");
	[self.rateSelectionViewContoller selectRateType:self.activeDays->intervalType];
	self.rateSelectionViewContoller.activeDays = self.activeDays;
	__weak SHRepeatLinkViewController *weakSelf = self;
	self.rateSelectionViewContoller.onCloseIntervalSelect = ^(SHIntervalType intervalType, int32_t intervalSize) {
		SHRepeatLinkViewController *bSelf = weakSelf;
		if(nil == bSelf) return;
		bSelf.activeDays->intervalType = intervalType;
		SH_setCurrentIntervalSize(bSelf.activeDays, intervalType, intervalSize);
		char *activeDaysDesc = SH_selectIntervalDescription(bSelf.activeDays);
		bSelf.descriptionLabel.text = [NSString stringWithUTF8String:activeDaysDesc];
		free(activeDaysDesc);
	};
	[self.editorContainer
		arrangeAndPushChildVCToFront:self.rateSelectionViewContoller];
}


@end
