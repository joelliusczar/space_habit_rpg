//
//  SubtasksTableViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SubtasksTableViewController.h"

@interface SubtasksTableViewController ()

@end

@implementation SubtasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
