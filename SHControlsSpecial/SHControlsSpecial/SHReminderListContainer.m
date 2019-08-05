//
//  ReminderListContainer.m
//  SHControlsSpecial
//
//  Created by Joel Pridgen on 8/4/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHReminderListContainer.h"
#import "SHReminderListView.h"
#import <SHControls/UIViewController+Helper.h>

@interface SHReminderListContainer ()

@end

@implementation SHReminderListContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    SHReminderListView *reminderList = [SHReminderListView
      newWithContext:self.context
      withObjectIDWrapper:self.objectIDWrapper];
    [self pushChildVC:reminderList toViewOfParent:self.container];
    // Do any additional setup after loading the view from its nib.
}


-(void)setupWithContext:(NSManagedObjectContext *)context
  andObjectID:(SHObjectIDWrapper*)objectIDWrapper
{
  self.context = context;
  self.objectIDWrapper = objectIDWrapper;
}

-(IBAction)back_button_tap:(UIButton *)sender forEvent:(UIEvent *)event {
  (void)sender; (void)event;
  [self popVCFromFront];
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
