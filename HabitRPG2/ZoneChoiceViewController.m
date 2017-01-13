//
//  ZoneChoice.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneChoiceViewController.h"

@interface ZoneChoiceViewController ()
-(instancetype)initWithBase:(UIViewController<ChoiceScreenBase> *)screenBase;
@property (nonatomic,weak) UIViewController<ChoiceScreenBase> * screenBase;
@end

@implementation ZoneChoiceViewController

-(instancetype)initWithBase:(UIViewController<ChoiceScreenBase> *)screenBase{
    if(self = [self initWithNibName:@"ZoneChoiceView" bundle:nil]){
        self.screenBase = screenBase;
    }
    return self;
}

+(instancetype)constructWithBase:(UIViewController<ChoiceScreenBase> *)screenBase{
    return [[ZoneChoiceViewController alloc] initWithBase:screenBase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
