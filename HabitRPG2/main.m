//
//  main.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

static bool isRunningTests()
{
    NSDictionary* environment = [[NSProcessInfo processInfo] environment];
    NSString* testEnabled = environment[@"IS_UNIT_TESTING"];
    return [testEnabled isEqualToString:@"YES"];
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (isRunningTests()) {
            return UIApplicationMain(argc, argv, nil, nil);
        }else{
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
}
