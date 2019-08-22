//
//	FlexibleConstants.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 12/6/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHFlexibleConstants.h"


@implementation SHFlexibleConstants
{
	NSArray *_weekday_keys;
}
-(NSUInteger)DAYS_IN_WEEK{
	return self.WEEKDAY_KEYS.count;
}

-(NSArray<NSString *> *)WEEKDAY_KEYS{
	if(nil == _weekday_keys){
		_weekday_keys = @[@"SUN",@"MON",@"TUE",@"WED",@"THR",@"FRI",@"SAT"];
	}
	return _weekday_keys;
}
@end
