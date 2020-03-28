//
//  SHTransparentModalViewController.m
//  SHControls
//
//  Created by Joel Pridgen on 3/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHTransparentModalViewController.h"

@interface SHTransparentModalViewController ()

@end

@implementation SHTransparentModalViewController

@synthesize widthConstraint = _widthConstraint;
@synthesize heightConstraint = _heightConstraint;

-(instancetype)initWithModalViewController:(SHViewController<SHModalContentProtocol> *)modalViewController {
	NSBundle *bundle = [NSBundle bundleForClass:self.class];
	if(self = [super initWithNibName:NSStringFromClass(self.class) bundle:bundle]) {
		_modalContentViewController = modalViewController;
		_modalContentViewController.modalContentPresenter = self;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushChildVC:self.modalContentViewController toViewOfParent:self.modalContentView];
}


@end
