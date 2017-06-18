//
//  SubtasksTableViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SubtasksTableView.h"

@interface SubtasksTableView ()

@end

@implementation SubtasksTableView

-(instancetype)new{
    return [[NSBundle mainBundle] loadNibNamed:@"SubtasksTableView" owner:self options:nil][0];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.delegate){
        return [self.delegate tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate){
        return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    //this will crash because the delegate needs to implement tableView:cellForRowAtIndexPath:
    return nil;
}

@end
