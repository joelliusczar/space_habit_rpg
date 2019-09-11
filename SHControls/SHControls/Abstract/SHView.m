//
//	SHView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/7/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHView.h"
#import <SHCommon/NSObject+Helper.h>
#import "UIView+Helpers.h"
#import <SHCommon/SHInterceptor.h>


@implementation SHView

@synthesize eventDelegate = _eventDelegate;
-(id<SHViewEventsProtocol>)eventDelegate{
	if(self->_eventDelegate){
		return _eventDelegate;
	}
	if(self.mainView){
		if([self.mainView isKindOfClass:SHView.class]){
			SHView *shview = (SHView*)self.mainView;
			return shview->_eventDelegate;
		}
	}
	return nil;
}

-(void)setEventDelegate:(id<SHViewEventsProtocol>)eventDelegate{
	if(self.mainView){
		if([self.mainView isKindOfClass:SHView.class]){
			SHView *shview = (SHView*)self.mainView;
			shview->_eventDelegate = eventDelegate;
		}
	}
	else {
		_eventDelegate = eventDelegate;
	}
}


-(instancetype)initWithFrame:(CGRect)frame{
	if(self = [super initWithFrame:frame]){
		[self viewAdditionalSetup];
	}
	return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
	if(self = [super initWithCoder:coder]){
		[self viewAdditionalSetup];
	}
	return self;
}


-(instancetype)initEmpty{
	if(self = [super initWithFrame:CGRectZero]){}
	return self;
}


-(void)viewAdditionalSetup{
	//only do this part if there is an actual xib to load
	//we're checking that this is a derived class
	//as opposed to the base class itself.
	if(![self isMemberOfClass:SHView.class]){
		_mainView = [self loadDefaultXib];
		if(_mainView) {
			[self addSubview:_mainView];
			//this is neccessary because other wise the outer frame
			//is too small and invisibly blocks user actions.
			[self resizeFrame:_mainView.frame.size];
			//#note: this line is not fully tested
			//[_mainView createFillUpLayoutConstraints:self];
		}
	}
	[self setupCustomOptions];
}


-(void)beginTap_action:(UITouch *)touch
	withEvent:(UIEvent *)event
{
	(void)touch;
	(void)event;
}



//override in subclass
-(void)setupCustomOptions{}

//I'm depending on subclasses being able to override this
-(UIView *)loadDefaultXib{
	return [self loadXib:(NSStringFromClass(self.class))];
}


//deprecated. I've discovered it is much less easier to use apple's auto-layout
//so that I don't have to always be resizing both self and mainView
-(void)resizeHeightByOffset:(CGFloat)offset{
	[super resizeHeightByOffset:offset];
	[self.mainView resizeHeightByOffset:offset];
}


//deprecated. I've discovered it is much less easier to use apple's auto-layout
-(void)resizeFrame:(CGSize)size{
	[super resizeFrame:size];
	[self.mainView resizeFrame:size];
}


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.mainView.backgroundColor = color;
	self.backgroundColor = color;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches
	withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {
		if(touch.phase == UITouchPhaseBegan){
			[self beginTap_action:touch withEvent:event];
			if([self.eventDelegate respondsToSelector:@selector(onBeginTap_action:withEvent:)]){
				[self.eventDelegate onBeginTap_action:self withEvent:event];
			}
		}
	}
}


@end
