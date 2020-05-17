//
//  SimpleClass.h
//  SHCommon
//
//  Created by Joel Pridgen on 5/16/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#if TARGET_OS_MACCATALYST || TARGET_OS_IOS
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface SimpleClass : NSObject

@end

NS_ASSUME_NONNULL_END

#endif
