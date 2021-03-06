//
//  SHWeeklyRateItem.h
//  SHModels
//
//  Created by Joel Pridgen on 5/10/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
#import <SHSpecial_C/SHRateValueItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHWeeklyRateItem : NSObject

@property (nonatomic) BOOL isDayActive;
@property (nonatomic) NSInteger backrange;
@property (nonatomic) NSInteger forrange;
-(void)copyFromCStruct:(SHRateValueItem *)rvi;
-(void)copyIntoCStruct:(SHRateValueItem *)rvi;


@end

NS_ASSUME_NONNULL_END
