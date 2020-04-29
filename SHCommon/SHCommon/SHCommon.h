//
//	SHCommon.h
//	SHCommon
//
//	Created by Joel Pridgen on 2/23/18.
//	Copyright Â© 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>
#if TARGET_OS_MACCATALYST || TARGET_OS_IOS
//! Project version number for SHCommon.
FOUNDATION_EXPORT double SHCommonVersionNumber;

//! Project version string for SHCommon.
FOUNDATION_EXPORT const unsigned char SHCommonVersionString[];
// In this header, you should import all the public headers of your framework using statements like #import <SHCommonUtilities/PublicHeader.h>

#endif

#import "SHInterceptorProtocol.h"
#import "SHInterceptor.h"
#import "NSObject+Helper.h"
#import "NSException+SHCommonExceptions.h"
#import "SHResourceUtilityProtocol.h"
#import "SHSingletonCluster.h"
#import "SHResourceUtility.h"
#import "SHReportServiceCallerProtocol.h"
#import "SHColorInversionHintProtocol.h"
#import "SHReportServiceCaller.h"
#import "SHCommonUtils.h"
#import "NSLocale+Helper.h"
#import "NSDate+DateHelper.h"
#import "NSMutableArray+Helper.h"
#import "NSMutableDictionary+Helper.h"
#import "NSNumber+Helper.h"
#import "SHMath.h"
#import "SHVarWrapper.h"
#import "SHKeyToken.h"
#import "SHProbWeight.h"
#import "SHObject.h"
#import "NSDictionary+SHHelper.h"
#import "NSArray+SHHelper.h"
#import "NSSet+SHHelper.h"
#import "NSOrderedSet+SHHelper.h"
#import "SHCollectionUtils.h"
#import "SHDebugDefines.h"
#import "SHMappableProtocol.h"
#import "SHDateProviderProtocol.h"
#import "SHDefaultDateProvider.h"
#import "SHObjectIDWrapper.h"
#import "NSManagedObjectContext+Helper.h"
#import "SHDataProviderProtocol.h"
#import "SHCoreData.h"
#import "SHConstants.h"
#import "SHCommonTypeDefs.h"
#import "SHIconDrawingFunctions.h"
#import "SHInheritanceTreeNode.h"
#import "SHInheritanceTree.h"
#import "SHNotificationHelper.h"
#import "UIColor+Helper.h"
#import "SHIconBuilder.h"
#import "UIImage+Helper.h"
