//
//  SHSubtasksTableViewDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHCommonDelegateProtocol.h"
@import Foundation;
@import UIKit;

@protocol SHSubtasksTableViewDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
