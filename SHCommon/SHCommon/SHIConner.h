//
//  SHIconBuilder.h
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#if TARGET_OS_MACCATALYST || TARGET_OS_IOS
@import UIKit;




NS_ASSUME_NONNULL_BEGIN

@interface SHIconner : NSObject

@end

NS_ASSUME_NONNULL_END

#endif

