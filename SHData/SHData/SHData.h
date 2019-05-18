//
//  SHData.h
//  SHData
//
//  Created by Joel Pridgen on 2/24/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#if IS_IOS
#import <UIKit/UIKit.h>

//! Project version number for SHData.
FOUNDATION_EXPORT double SHDataVersionNumber;

//! Project version string for SHData.
FOUNDATION_EXPORT const unsigned char SHDataVersionString[];

#endif

// In this header, you should import all the public headers of your framework using statements like #import <SHData/PublicHeader.h>
#import "SHCoreDataProtocol.h"
#import "SHCoreData.h"
#import "SingletonCluster+Data.h"
#import "NSManagedObjectContext+Helper.h"
#import "SHObjectIDWrapper.h"

