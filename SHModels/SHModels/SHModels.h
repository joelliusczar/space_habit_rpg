//
//  SHModels.h
//  SHModels
//
//  Created by Joel Pridgen on 2/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#if IS_IOS

#import <UIKit/UIKit.h>

//! Project version number for SHModels.
FOUNDATION_EXPORT double SHModelsVersionNumber;

//! Project version string for SHModels.
FOUNDATION_EXPORT const unsigned char SHModelsVersionString[];

#endif

#import "SHModelConstants.h"
#import "SHItemTransaction+CoreDataClass.h"
#import "SHItemTransaction+CoreDataProperties.h"
#import "SHSettings+CoreDataProperties.h"
#import "SHSettings+CoreDataClass.h"
#import "P_SHDueDateItem.h"
#import "SHMonsterTransaction+CoreDataProperties.h"
#import "SHMonsterTransaction+CoreDataClass.h"
#import "SHCounter+CoreDataClass.h"
#import "SHCounter+CoreDataProperties.h"
#import "SHCounterTransaction+CoreDataClass.h"
#import "SHCounterTransaction+CoreDataProperties.h"
#import "SHSector+CoreDataProperties.h"
#import "SHSector+CoreDataClass.h"
#import "SHReminder+CoreDataClass.h"
#import "SHReminder+CoreDataProperties.h"
#import "SHDailyTransaction+CoreDataClass.h"
#import "SHDailyTransaction+CoreDataProperties.h"
#import "SHSuffix+CoreDataProperties.h"
#import "SHSuffix+CoreDataClass.h"
#import "SHDaily+CoreDataClass.h"
#import "SHDaily+CoreDataProperties.h"
#import "P_SHStoryItem.h"
#import "SHTodo+CoreDataClass.h"
#import "SHTodo+CoreDataProperties.h"
#import "SHMonsterInfoDictionary.h"
#import "SHSectorInfoDictionary.h"
#import "SHStoryItemDictionary.h"
#import "OnlyOneEntities.h"
#import "SHItem+CoreDataClass.h"
#import "SHItem+CoreDataProperties.h"
#import "SHDailySubTask+CoreDataClass.h"
#import "SHDailySubTask+CoreDataProperties.h"
#import "SHSectorTransaction+CoreDataClass.h"
#import "SHSectorTransaction+CoreDataProperties.h"
#import "SHRateTypeHelper.h"
#import "SHHero+CoreDataClass.h"
#import "SHHero+CoreDataProperties.h"
#import "SHDaily+ActiveDays.h"
#import "SHDaily+Mapable.h"
#import "SHSHDaily+Helper.h"
#import "SHTodoTransaction+CoreDataProperties.h"
#import "SHTodoTransaction+CoreDataClass.h"
#import "P_SHTransaction.h"
#import "SHMonster+CoreDataProperties.h"
#import "SHMonster+CoreDataClass.h"
#import "SHModels.h"
#import "SHModelTools.h"
#import "ShMonsterTransaction_Medium.h"
#import "SHSectorTransaction_Medium.h"
#import "SHSector_Medium.h"
#import "SHMonster_Medium.h"
#import "SHDaily_Medium.h"
#import "SHSectorDTO.h"
#import "SHHeroDTO.h"
#import "SHMonsterDTO.h"
#import "SHDueDateItem.h"
#import "SHReminderDTO.h"
#import "SHSettingsDTO.h"
#import "SHDailyDTO.h"

// In this header, you should import all the public headers of your framework using statements like #import <SHModels/PublicHeader.h>


