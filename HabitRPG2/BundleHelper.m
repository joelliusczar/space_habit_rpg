//
//  BundleHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "BundleHelper.h"

@implementation BundleHelper
+(NSBundle *)getCorrectBundleForEnvironment:(nonnull Class)aClass AndTest:(BOOL)isTest{
    if(isTest){
        return [NSBundle bundleForClass:aClass];
    }
    else{
        return [NSBundle mainBundle];
    }
}
@end
