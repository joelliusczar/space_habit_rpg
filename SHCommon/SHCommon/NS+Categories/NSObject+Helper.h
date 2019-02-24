//
//  NSObject+Helper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#if USE_UIKIT_PUBLIC_HEADERS
@import UIKit;
#endif

@interface NSObject (Helper)
-(void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
                  context:(void *)context;
#if USE_UIKIT_PUBLIC_HEADERS
-(UIView *)loadXib:(NSString *)nibName;
#endif
@end
