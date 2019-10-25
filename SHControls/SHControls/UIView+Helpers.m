//
//	UIView+Helpers.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/21/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//


#import "UIView+Helpers.h"
@import Foundation;
@import SHCommon;


@implementation UIView (Helpers)

-(void)resizeHeightByOffset:(CGFloat)offset{
	CGRect frame = self.frame;
	frame.size.height += offset;
	self.frame = frame;
}


-(void)resizeAutoLayoutHeightByOffset:(CGFloat)offset{
	CGFloat height = self.frame.size.height;
	[self.heightAnchor constraintEqualToConstant:height + offset].active = YES;
}


-(void)setupBorder:(UIRectEdge)edges
	 withThickness:(CGFloat)thickness
			andColor:(UIColor *)color{
	CALayer *layer = self.layer;
	if(edges&UIRectEdgeTop){
		CALayer *borderLayer = [[CALayer alloc] init];
		borderLayer.backgroundColor = color.CGColor;
		borderLayer.frame = CGRectMake(0,0,self.frame.size.width,thickness);
		[layer addSublayer:borderLayer];
	}
	if(edges&UIRectEdgeLeft){
		CALayer *borderLayer = [[CALayer alloc] init];
		borderLayer.backgroundColor = color.CGColor;
		borderLayer.frame = CGRectMake(0,0,thickness,self.frame.size.height);
		[layer addSublayer:borderLayer];
	}
	if(edges&UIRectEdgeRight){
		CALayer *borderLayer = [[CALayer alloc] init];
		borderLayer.backgroundColor = color.CGColor;
		CGFloat offsetX = self.frame.size.width - thickness;
		borderLayer.frame = CGRectMake(offsetX,0,thickness,self.frame.size.height);
		[layer addSublayer:borderLayer];
	}
	if(edges&UIRectEdgeBottom){
		CALayer *borderLayer = [[CALayer alloc] init];
		borderLayer.backgroundColor = color.CGColor;
		CGFloat offsetY = self.frame.size.height -thickness;
		borderLayer.frame = CGRectMake(0,offsetY,self.frame.size.width,thickness);
		[layer addSublayer:borderLayer];
	}
	
}


-(void)resizeFrame:(CGSize)size{
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}


-(void)replaceSubviewsWith:(UIView *)view{
	for(UIView *v in self.subviews){
		[v removeFromSuperview];
	}
	if(view){
		[self addSubview:view];
	}
}

//deprecated
-(void)invertViewColors{
	UIColor *c;
	if([self respondsToSelector:@selector(setTextColor:)]
		&&[self respondsToSelector:@selector(textColor)]){
		c = (UIColor *)[self valueForKey:@"textColor"];
		[self setValue:[c invertColor] forKey:@"textColor"];
	}
	if([self respondsToSelector:@selector(setTitleColor:forState:)]
		&&[self respondsToSelector:@selector(titleColorForState:)]){
		[self invertTitleColorForAllStates];
	}
	if([self respondsToSelector:@selector(setTitleShadowColor:forState:)]
		&&[self respondsToSelector:@selector(titleShadowColorForState:)]){
		[self invertTitleShadowColorForAllStates];
	}
	if([self respondsToSelector:@selector(setAreColorsInverted:)]
		&&[self respondsToSelector:@selector(areColorsInverted)]){
		BOOL areInverted = ((NSNumber *)[self valueForKey:@"areColorsInverted"]).boolValue;
		[self setValue:[NSNumber numberWithBool:!areInverted] forKey:@"areColorsInverted"];
	}
	c = self.backgroundColor;
	self.backgroundColor = [c invertColor];
}

-(void)applyVisualChangeToAllSubviews{
	if(UIAccessibilityIsInvertColorsEnabled()||isTestingInvert){
		[self invertViewColors];
	}
	if(!self.subviews.count){
		return;
	}
	
	for(UIView *subView in self.subviews){
		[subView applyVisualChangeToAllSubviews];
	}
}

#define INVERT_DISABLED 1
/*
I know this is now clutter and should be deleted, it's widespread enough
that it would be a pain in the ass to add back if I change my mind.
*/
-(void)checkForAndApplyVisualChanges{
#if INVERT_DISABLED
	return;
#else
	[self applyVisualChangeToAllSubviews];
#endif
}


-(void)invertTitleShadowColorForAllStates{
	SEL getterSEL = @selector(titleShadowColorForState:);
	SEL setterSEL = @selector(setTitleShadowColor:forState:);
	[self invertColorForPropertyForStateWithGetSelector:getterSEL AndSetSelector:setterSEL];
}

//deprecated
-(void)invertColorForPropertyForStateWithGetSelector:(SEL)getterSEL AndSetSelector:(SEL)setterSEL{
	UIColor *c;
	UIColor *inverted;
	typedef void (*setPropertyColorForState)(id,SEL,UIColor*,NSUInteger);
	typedef UIColor* (*getPropertyColorForState)(id,SEL,NSUInteger);
	getPropertyColorForState methodInvokeGet = (getPropertyColorForState)[self methodForSelector:getterSEL];
	setPropertyColorForState methodInvokeSet = (setPropertyColorForState)[self methodForSelector:setterSEL];
	//invert normal state
	c = methodInvokeGet(self,getterSEL,UIControlStateNormal);
	inverted = [c invertColor];
	methodInvokeSet(self,setterSEL,inverted,UIControlStateNormal);
	int UIControlStateMaxShift = 4;
	for(int i = 0;i<UIControlStateMaxShift;i++){
		NSUInteger controlState = 1 << i;
		c = methodInvokeGet(self,getterSEL,controlState);
		inverted = [c invertColor];
		methodInvokeSet(self,setterSEL,inverted,controlState);
	}
}

//deprecated
-(void)invertTitleColorForAllStates{
	SEL getterSEL = @selector(titleColorForState:);
	SEL setterSEL = @selector(setTitleColor:forState:);
	[self invertColorForPropertyForStateWithGetSelector:getterSEL AndSetSelector:setterSEL];
}


-(void)translateViewVertically:(CGFloat)offset{
	
	CGRect frame = self.frame;
	frame.origin.y += offset;
	self.frame = frame;
}


-(void)resetVerticalOrigin{
	CGRect frame = self.frame;
	frame.origin.y = 0;
	self.frame = frame;
}


-(void)tieConstaintsForsubordinateView:(UIView *)subordinateView{
	[self tieVerticalConstraintsForsubordinateView:subordinateView];
	[self tieHorizontalConstaintsForSubordinateView:subordinateView];
}


-(void)tieHorizontalConstaintsForSubordinateView:(UIView *)subordinateView{
	subordinateView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.leadingAnchor constraintEqualToAnchor:subordinateView.leadingAnchor].active = YES;
	[self.trailingAnchor constraintEqualToAnchor:subordinateView.trailingAnchor].active = YES;
}


-(void)tieVerticalConstraintsForsubordinateView:(UIView*)subordinateView{
	subordinateView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.topAnchor constraintEqualToAnchor: subordinateView.topAnchor].active = YES;
	[self.bottomAnchor constraintEqualToAnchor:subordinateView.bottomAnchor].active = YES;
}


@end
