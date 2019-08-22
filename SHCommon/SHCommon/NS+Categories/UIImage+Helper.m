//
//  UIImage+Helper.m
//  SHCommon
//
//  Created by Joel Pridgen on 3/5/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#if IS_IOS

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

-(UIImage *)invertImageColors{
	CIImage *cImg = [CIImage imageWithCGImage:self.CGImage];
	CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
	[filter setValue:cImg forKey:kCIInputImageKey];
	CIImage *result = [filter valueForKey:kCIOutputImageKey];
	return [UIImage imageWithCIImage:result scale:self.scale orientation:self.imageOrientation];
}

@end

#endif
