//
//	SHView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/7/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHView.h"
#import "UIView+Helpers.h"
@import SHCommon;


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
	self = [self getTrueInstance];
	if(self = [super initWithFrame:frame]){
		[self setupCustomOptions];
	}
	return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
	if(self = [super initWithCoder:coder]){
		self = [self getTrueInstance];
		//[self setupCustomOptions];
	}
	return self;
}


-(instancetype)initEmpty{
	if(self = [super initWithFrame:CGRectZero]){}
	return self;
}


-(instancetype)getTrueInstance {
//	SHView *instance = [self loadDefaultXib];
//	if(instance) return instance;
//	instance = self;
//	return instance;
return self;
}


-(id)awakeAfterUsingCoder:(NSCoder *)coder {
	id instance = [self loadDefaultXib];
	if(instance) return instance;
	instance = self;
	return instance;
}


-(void)viewAdditionalSetup{
	//only do this part if there is an actual xib to load
	//we're checking that this is a derived class
	//as opposed to the base class itself.
	if(![self isMemberOfClass:SHView.class]){
		_mainView = [self loadDefaultXib];
		if(_mainView) {
			[self addSubview:_mainView];
			_mainView.translatesAutoresizingMaskIntoConstraints = NO;
			[self.leadingAnchor constraintEqualToAnchor:_mainView.leadingAnchor].active = YES;
			[self.topAnchor constraintEqualToAnchor:_mainView.topAnchor].active = YES;
			[self.trailingAnchor constraintEqualToAnchor:_mainView.trailingAnchor].active = YES;
			[self.bottomAnchor constraintEqualToAnchor:_mainView.bottomAnchor].active = YES;
		}
		self.backgroundColor = super.backgroundColor;
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


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.mainView.backgroundColor = color;
	self.backgroundColor = color;
}


-(UIColor*)backgroundColor {
	return super.backgroundColor;
}


-(void)setBackgroundColor:(UIColor *)backgroundColor {
	self.mainView.backgroundColor = backgroundColor;
	super.backgroundColor = backgroundColor;
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
