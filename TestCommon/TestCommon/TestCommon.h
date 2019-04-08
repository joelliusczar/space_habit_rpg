//
//  TestCommon.h
//  TestCommon
//
//  Created by Joel Pridgen on 3/6/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#if IS_IOS
#import <UIKit/UIKit.h>

//! Project version number for TestCommon.
FOUNDATION_EXPORT double TestCommonVersionNumber;

//! Project version string for TestCommon.
FOUNDATION_EXPORT const unsigned char TestCommonVersionString[];

#endif


// In this header, you should import all the public headers of your framework using statements like #import <TestCommon/PublicHeader.h>

#import "FrequentCase.h"
#import "TestHelpers.h"
#import "TestGlobals.h"
#import "TestDummy.h"
#import "NSManagedObjectContext+Hijack.h"
