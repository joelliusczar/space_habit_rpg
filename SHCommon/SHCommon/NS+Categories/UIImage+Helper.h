//
//  UIImage+Helper.h
//  SHCommon
//
//  Created by Joel Pridgen on 3/5/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <TargetConditionals.h>


#if TARGET_OS_MACCATALYST || TARGET_OS_IOS

@import UIKit;

@interface UIImage (Helper)
-(UIImage *)invertImageColors;
@end

#endif
