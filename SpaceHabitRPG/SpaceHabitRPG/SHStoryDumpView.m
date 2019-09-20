//
//	SHStoryDumpView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHStoryDumpView.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/NSException+SHCommonExceptions.h>

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


-(instancetype)initWithStoryItemObjectID:(SHStoryItemObjectID *)storyItemObjectID{
	if(self = [self initWithDefaultNib]){
		_storyItemObjectID = storyItemObjectID;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	NSManagedObjectContext *context = self.storyItemObjectID.context;
	[context performBlock:^{
		NSError *error = nil;
		NSManagedObject<SHStoryItemProtocol>* storyItem = [context getEntityOrNil:self.storyItemObjectID
			withError:&error];
		if(error) {
			@throw [NSException dbException:error];
		}
		NSString *synopsis = nil != storyItem ? storyItem.synopsis:@"";
		NSString *headline = nil != storyItem ? storyItem.headline:@"";
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.synopsisView.text = synopsis;
			self.headlineLbl.text = headline;
			[self.headlineLbl sizeToFit];
			[self.view addGestureRecognizer:self.tapper];
		}];
	}];

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
