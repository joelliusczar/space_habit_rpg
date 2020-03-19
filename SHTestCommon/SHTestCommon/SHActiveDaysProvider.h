//
//  SHActiveDaysProvider.h
//  SHTestCommon
//
//  Created by Joel Pridgen on 3/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SHModels;

NS_ASSUME_NONNULL_BEGIN

@interface SHActiveDaysProvider : NSObject
@property (strong, nonatomic) SHDailyActiveDays *activeDays;
-(SHDailyActiveDays * _Nonnull)tuesWedThursSat;
-(SHDailyActiveDays * _Nonnull)sunMonThursFri;
@end

NS_ASSUME_NONNULL_END
