//
//  SHIntervalItemFormat.m
//  SHModels
//
//  Created by Joel Pridgen on 1/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHIntervalItemFormat.h"
@import SHCommon;

@implementation SHIntervalItemFormat

+(NSString*)singularFormatString {
	@throw [NSException abstractException];
}


+(NSString*)pluralFormatString {
	@throw [NSException abstractException];
}

-(NSString *)intervalDescription {
	NSString *formatString = [self.class getFormatStringTypeForIntervalSize:self.intervalSize];
	NSString *desc = [NSString stringWithFormat:formatString,self.intervalSize];
	return desc;
}


-(NSString*)intervalLabelDescription {
	@throw [NSException abstractException];
}


+(NSString *)getFormatStringTypeForIntervalSize:(NSInteger)intervalSize {
	NSString *result = intervalSize == 1 ? self.singularFormatString : self.pluralFormatString;
	return result;
}

@end
