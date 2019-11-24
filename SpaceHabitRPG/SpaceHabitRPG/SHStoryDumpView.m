//
//	SHStoryDumpView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHStoryDumpView.h"
@import SHControls;
@import SHCommon;

@interface SHStoryDumpView ()
@property (nonatomic,strong) UITapGestureRecognizer *tapper;
@end

@implementation SHStoryDumpView



-(UITapGestureRecognizer *)tapper{
	if(!_tapper){
		_tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
			action:@selector(handleTap:)];
	}
	return _tapper;
}


-(UIColor *)backgroundColor{
	return self.view.backgroundColor;
}


-(void)setBackgroundColor:(UIColor *)backgroundColor{
	self.view.backgroundColor = backgroundColor;
}


-(instancetype)initWithDefaultNib{
	if(self = [super initWithNibName:@"SHStoryDumpView" bundle:nil]){}
	return self;
}


-(instancetype)initWithStoryItemObject:(NSObject<SHStoryItemProtocol> *)storyItemObject{
	if(self = [self initWithDefaultNib]){
		_storyItemObject = storyItemObject;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	NSObject<SHStoryItemProtocol> *storyItem = self.storyItemObject;
	NSString *synopsis = nil != storyItem ? storyItem.synopsis:@"";
	NSString *headline = nil != storyItem ? storyItem.headline:@"";
	self.synopsisView.text = synopsis;
	self.headlineLbl.text = headline;
	[self.headlineLbl sizeToFit];
	[self.view addGestureRecognizer:self.tapper];
}

- (void)didReceiveMemoryWarning {
		[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

- (IBAction)doneBtn_pressed_action:(SHButton *)sender forEvent:(UIEvent *)event {
		if(self.responseBlock){
			self.responseBlock(self);
		}
		[self popVCFromFront];
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer{
	NSLog(@"Tap tap");
}


@end
