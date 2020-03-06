//
//	UIView+Helpers.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/21/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//


#import "UIView+Helpers.h"
#import <objc/runtime.h>
@import Foundation;
@import SHCommon;


@implementation UIView (Helpers)


-(UIColor *)SH_borderColor {
	CGColorRef cgColor = self.layer.borderColor;
	return [UIColor colorWithCGColor:cgColor];
}


-(void)setSH_borderColor:(UIColor *)borderColor {
	self.layer.borderColor = borderColor.CGColor;
}


-(CGFloat)SH_borderWidth {
	CGFloat width = self.layer.borderWidth;
	return width;
}


-(void)setSH_borderWidth:(CGFloat)borderWidth {
	self.layer.borderWidth = borderWidth;
}


-(CGFloat)SH_cornerRadius {
	CGFloat cornerRadius = self.layer.cornerRadius;
	return cornerRadius;
}


-(void)setSH_cornerRadius:(CGFloat)SH_cornerRadius {
	self.layer.cornerRadius = SH_cornerRadius;
}


//deprecated
-(void)invertViewColors{
	UIColor *c = nil;
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
	UIColor *c = nil;
	UIColor *inverted = nil;
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


-(UIView *)loadXib:(NSString *)nibName{
		NSBundle *bundle = [NSBundle bundleForClass:self.class];
		@try {
			NSArray *nibs = [bundle loadNibNamed:nibName owner:self options:nil];
			if(nibs.count > 0) {
				return nibs[0];
			}
		return nil;
		}
		@catch (NSException *exception) {
			return nil;
		}
	
}

@end
