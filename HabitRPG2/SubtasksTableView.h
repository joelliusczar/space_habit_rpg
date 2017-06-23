//
//  SubtasksTableViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_SubtasksTableViewDelegate.h"

@interface SubtasksTableView : UIView<UITableViewDataSource>
@property (weak,nonatomic) IBOutlet SubtasksTableView *mainView;
@property (weak,nonatomic) IBOutlet UITableView *subtasksList;
@property (weak,nonatomic) id<P_SubtasksTableViewDelegate> delegate;
@end
