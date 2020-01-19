//
//  SHScrollAnimator.m
//  SHControls
//
//  Created by Joel Pridgen on 11/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHScrollAnimator.h"

static NSInteger SEGMENT_SIZE = 300;

@interface SHScrollAnimator ()
@property (strong, nonatomic) CABasicAnimation *currentAnimation;
@property (assign, nonatomic) CGFloat useSegmentSize;
@property (readonly, nonatomic) CFTimeInterval duration;
@end

@implementation SHScrollAnimator


-(instancetype)initWithScrollView:(UIView *)scrollContent
	withScrollLength:(CGFloat)scrollLength
{
	if(self = [super init]){
		_scrollContent = scrollContent;
		_scrollLength = scrollLength;
		_useSegmentSize = scrollLength > SEGMENT_SIZE ? SEGMENT_SIZE : scrollLength;
	}
	return self;
}


-(CFTimeInterval)duration{
	double scrollRate = self.scrollLength *.07;
	return self.scrollLength / scrollRate;
}

-(animationBlock)getNewAnimationBlockWithLastRunFlag:(BOOL)isLastRun {
	return ^{
		self.currentAnimation = [CABasicAnimation animation];
		self.currentAnimation.delegate = self;
		self.currentAnimation.duration = [self duration];
		if(isLastRun) {
			self.currentAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
		}
		CGRect lastBounds = self.scrollContent.layer.bounds;
		CGRect newBounds = lastBounds;
		newBounds.origin.y += self.useSegmentSize;
		self.currentAnimation.fromValue = @(lastBounds);
		self.currentAnimation.toValue = @(newBounds);
		[self.scrollContent.layer addAnimation:self.currentAnimation forKey:@"bounds"];
		self.scrollContent.layer.bounds = newBounds;
	};
}


-(void)runAnimationWithLastRunFlag:(BOOL)isLastRun {
	dispatch_async(dispatch_get_main_queue(),[self getNewAnimationBlockWithLastRunFlag:isLastRun]);
}

-(void)startAnimation {
	[self runAnimationWithLastRunFlag:NO];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	(void)anim;
	if(flag) {
		CGFloat currentY = self.scrollContent.layer.bounds.origin.y;
		if(currentY < self.scrollLength) {
			CGFloat nextY = currentY + self.useSegmentSize;
			BOOL isLastRun = nextY >= self.scrollLength;
			if(isLastRun) {
				self.useSegmentSize = self.scrollLength - currentY;
			}
			[self runAnimationWithLastRunFlag: isLastRun];
			return;
		}
	}
	else {
		CGRect finalBounds = self.scrollContent.layer.bounds;
		finalBounds.origin.y = self.scrollLength;
		self.scrollContent.layer.bounds = finalBounds;
	}
	if(self.onAnimationFinish) {
		self.onAnimationFinish();
	}
}


-(void)stopAnimation{
	[self.scrollContent.layer removeAnimationForKey:@"bounds"];
}

@end
