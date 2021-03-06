//
//  SectorDescriptionViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorDescriptionViewController.h"
@import SHControls;
@import SHCommon;



@interface SHSectorDescriptionViewController ()
@property (readonly,strong,nonatomic) UISwipeGestureRecognizer *backSwipe;
@end

@implementation SHSectorDescriptionViewController


@synthesize backSwipe = _backSwipe;
-(UISwipeGestureRecognizer *)backSwipe{
	if(!_backSwipe){
		_backSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipe_rightSwipe_action:)];
		_backSwipe.direction = UISwipeGestureRecognizerDirectionRight;
	}
	return _backSwipe;
}


-(instancetype)initWithOnSelectionAction:(void (^)(SHSector*))onSectorSelectionAction
{
	if(self = [self initWithDefaultNib]){
		_onSectorSelectionAction = onSectorSelectionAction;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	[self.doneBtn setTitle:@"Pick this Sector" forState:UIControlStateNormal];
	[self.doneBtn sizeToFit];
	[self.view addGestureRecognizer:self.backSwipe];
	self.headlineLbl.text = @"";
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(void)backSwipe_rightSwipe_action:(UISwipeGestureRecognizer *)sender{
	(void)sender;
	[self popVCFromFront];
}


- (IBAction)doneBtn_pressed_action:(UIButton *)sender forEvent:(UIEvent *)event{
	(void)sender; (void)event;
	[self.prevViewController popVCFromFront];
	if(self.onSectorSelectionAction) {
		self.onSectorSelectionAction(self.sector); //[self.central afterSectorPick:(SHSectorDTO *)self.storyItem];
	}
}


@end
