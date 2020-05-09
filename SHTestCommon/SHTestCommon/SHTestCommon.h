//
//  SHTestCommon.h
//  SHTestCommon
//
//  Created by Joel Pridgen on 3/6/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <TargetConditionals.h>

#if !TARGET_OS_OSX

@import UIKit;

//! Project version number for SHTestCommon.
FOUNDATION_EXPORT double SHTestCommonVersionNumber;

//! Project version string for SHTestCommon.
FOUNDATION_EXPORT const unsigned char SHTestCommonVersionString[];

#endif

// In this header, you should import all the public headers of your framework using statements like #import <TestCommon/PublicHeader.h>

#import "FrequentCase.h"
#import "TestGlobals.h"
#import "TestDummy.h"
#import "SHCoreData+CleanUp.h"
#import "SHTestDateProvider.h"
#import "SHTestResourceUtil.h"
