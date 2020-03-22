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
	[self finishSetup];
}


-(void)finishSetup {
	NSAssert(self.context,@"You forgot to call setupWithContext:andObjectID:");
	[self.context performBlock:^{
		SHDaily *daily = (SHDaily *)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		SHRateType rateType = (SHRateType)daily.rateType;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.primaryLabel.text = @"Interval: ";
			SHIntervalItemFormat *intervalItem = [self.activeDays selectRateItemCollection:rateType];
			NSString *desc = intervalItem.intervalLabelDescription;
			self.descriptionLabel.text = desc;
			self.rateType = rateType;
		}];
	}];
}


-(void)openNextScreen{
	NSAssert(self.activeDays,@"You forgot to assign activeDays");
	[self.rateSelectionViewContoller selectRateType:self.rateType];
	self.rateSelectionViewContoller.activeDays = self.activeDays;
	__weak SHRepeatLinkViewController *weakSelf = self;
	self.rateSelectionViewContoller.onCloseIntervalSelect = ^(SHRateType rateType, NSInteger intervalSize) {
		SHRepeatLinkViewController *bSelf = weakSelf;
		if(nil == bSelf) return;
		bSelf.interval = intervalSize;
		bSelf.rateType = rateType;
		NSString *desc = [bSelf.activeDays selectRateItemCollection:rateType].intervalLabelDescription;
		bSelf.descriptionLabel.text = desc;
	};
	[self.editorContainer
		arrangeAndPushChildVCToFront:self.rateSelectionViewContoller];
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
