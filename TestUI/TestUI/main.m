//
//	main.m
//	TestUI
//
//	Created by Joel Pridgen on 3/2/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "AppDelegate.h"
#import "SHTestObserver.h"
@import UIKit;

int main(int argc, char * argv[]) {
	@autoreleasepool {
		NSUserDefaults *defs = NSUserDefaults.standardUserDefaults;
		[defs setInteger:1 forKey:@"com.apple.CoreData.SQLDebug"];
		return UIApplicationMain(argc, argv, NSStringFromClass(SHTestObserver.class), NSStringFromClass([AppDelegate class]));
	}
}
