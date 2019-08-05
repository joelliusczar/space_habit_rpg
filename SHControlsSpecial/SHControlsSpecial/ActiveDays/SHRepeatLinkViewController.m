//
//  SHRepeatLinkViewController.m
//  SHControlsSpecial
//
//  Created by Joel Pridgen on 6/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRepeatLinkViewController.h"
#import "SHRateSelectionViewController.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHModels/SHDaily.h>
#import <SHCommon/NSException+SHCommonExceptions.h>


@interface SHRepeatLinkViewController ()
@property (strong,nonatomic) SHRateSelectionViewController *rateSelectionViewContoller;
@end

@implementation SHRepeatLinkViewController


-(SHRateSelectionViewController*)rateSelectionViewContoller{
  if(nil == _rateSelectionViewContoller){
    NSBundle *bundle = [NSBundle bundleForClass:SHRateSelectionViewController.class];
    _rateSelectionViewContoller = [[SHRateSelectionViewController alloc]
      initWithNibName:NSStringFromClass(SHRateSelectionViewController.class)
      bundle:bundle];
  }
  return _rateSelectionViewContoller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
