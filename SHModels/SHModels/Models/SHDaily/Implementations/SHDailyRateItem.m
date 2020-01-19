//
//  SHDailyRateItem.m
//  SHModels
//
//  Created by Joel Pridgen on 12/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyRateItem.h"

@implementation SHDailyRateItem

-(NSString*)singularFormatString {
	return @"Interval: Every day";
}


-(NSString*)pluralFormatString {
	return @"Interval: Every %ld days";
}

@end
