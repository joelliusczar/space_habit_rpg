//
//  SHDailyRateItem.m
//  SHModels
//
//  Created by Joel Pridgen on 12/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyRateItem.h"

@implementation SHDailyRateItem

+(NSString*)singularFormatString {
	return @"Every day";
}


+(NSString*)pluralFormatString {
	return @"Every %ld days";
}


-(NSString*)intervalLabelDescription {
	return self.intervalDescription;
}

@end
