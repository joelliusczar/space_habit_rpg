//
//  SubtasksTableViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSubtasksTableViewDelegateProtocol.h"
#import "SHView.h"
@import UIKit;

@interface SHSubtasksTableView : SHView<UITableViewDataSource>
@property (weak,nonatomic) IBOutlet UITableView *subtasksList;
@property (assign,nonatomic) id<SHSubtasksTableViewDelegateProtocol> subtasksTabledelegate;
@end
