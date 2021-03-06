//
//  SubtasksTableViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSubtasksTableView.h"

@interface SHSubtasksTableView ()

@end

@implementation SHSubtasksTableView


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if(self.subtasksTabledelegate){
		return [self.subtasksTabledelegate tableView:tableView numberOfRowsInSection:section];
	}
	return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(!self.subtasksTabledelegate){
		//this will crash because the delegate needs to implement tableView:cellForRowAtIndexPath:
		@throw [NSException exceptionWithName:@"missing delegate"
			reason:@"delegate needs to be instantiated" userInfo:nil];
	}
	return [self.subtasksTabledelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}


@end
