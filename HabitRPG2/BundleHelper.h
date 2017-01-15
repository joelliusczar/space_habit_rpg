//
//  BundleHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BundleHelper : NSObject
+(NSBundle *)getCorrectBundleForEnvironment:(Class)aClass AndTest:(BOOL)isTest;
@end
