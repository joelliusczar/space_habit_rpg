//
//	main.m
//	ObjCScriptRunner
//
//	Created by Joel Pridgen on 7/7/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "MassPrinter.h"
#import "PersonThingUser.h"
#import "Experiments.h"
#import "Experiments+Bravo.h"
#import "ChildMan.h"
#import "XPSideKick.h"
#import "NoArcExp.h"

int main(int argc, const char * argv[]) {
	(void)argc;
	(void)argv;
	@autoreleasepool {
		NSUserDefaults *defs = NSUserDefaults.standardUserDefaults;
		[defs setInteger:0 forKey:@"com.apple.CoreData.SQLDebug"];
		//NSInteger val =	[defs integerForKey:@"-com.apple.CoreData.SQLDebug"];
			[Experiments blockLocalObjRef];
			//[NoArcExp underRelease];
	}
	
	return 0;
}
