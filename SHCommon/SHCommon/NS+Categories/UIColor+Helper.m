//
//  UIColor+Helper.m
//  SHCommon
//
//  Created by Joel Pridgen on 3/5/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "UIColor+Helper.h"

#if TARGET_OS_MACCATALYST || TARGET_OS_IOS

@implementation UIColor (Helper)

-(UIColor *)invertColor{
	CGFloat r,g,b,a;
	[self getRed:&r green:&g blue:&b alpha:&a];
	return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

@end

#endif
