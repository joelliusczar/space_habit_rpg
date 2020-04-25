//
//  SHModels.h
//  SHModels
//
//  Created by Joel Pridgen on 2/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <TargetConditionals.h>

#if !TARGET_OS_OSX

@import UIKit;

//! Project version number for SHModels.
FOUNDATION_EXPORT double SHModelsVersionNumber;

//! Project version string for SHModels.
FOUNDATION_EXPORT const unsigned char SHModelsVersionString[];

#endif


#import "SHModelConstants.h"
#import "SHConfig.h"
#import "SHDueDateItemProtocol.h"
#import "SHCounter.h"
#import "SHSector.h"
#import "SHReminder.h"
#import "SHReminder+CoreDataProperties.h"
#import "SHSuffix.h"
#import "SHDaily.h"
#import "SHDailyEvent.h"
#import "SHDaily+CoreDataProperties.h"
#import "SHStoryItemProtocol.h"
#import "SHTodo.h"
#import "SHTodo+CoreDataProperties.h"
#import "SHMonsterInfoDictionary.h"
#import "SHSectorInfoDictionary.h"
#import "SHStoryItemDictionary.h"
#import "SHItem.h"
#import "SHItem+CoreDataProperties.h"
#import "SHDailySubTask.h"
#import "SHDailySubTask+CoreDataProperties.h"
#import "SHRateTypeHelper.h"
#import "SHHero.h"
#import "SHMonster.h"
#import "SHModels.h"
#import "SHModelTools.h"
#import "SHTransaction_Medium.h"
#import "SHSector_Medium.h"
#import "SHDaily_Medium.h"
#import "SHCategory.h"
#import "SHCategory+CoreDataProperties.h"
#import "SHTeapot.h"
#import "SHTeapot+CoreDataProperties.h"
#import "SHBundleKey.h"
#import "Model+CoreDataModel.h"
#import "SHMonthlyYearlyRateItem.h"
#import "SHMonthlyYearlyRateItemList.h"
#import "SHDailyActiveDays.h"
#import "SHDailyValidation.h"
#import "SHDailyNextDueDateCalculator.h"
#import "SHDailyMaxDaysBeforeSpanCalculator.h"
#import "SHTitleProtocol.h"
#import "SHDailyActivator.h"
#import "SHMonster_Medium.h"
#import "SHWeekIntervalItemList.h"
#import "SHIntervalItemFormat.h"

// In this header, you should import all
//the public headers of your framework using statements like #import <SHModels/PublicHeader.h>


