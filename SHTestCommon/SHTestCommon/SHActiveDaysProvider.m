//
//  SHActiveDaysProvider.m
//  SHTestCommon
//
//  Created by Joel Pridgen on 3/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHActiveDaysProvider.h"



@implementation SHActiveDaysProvider

-(SHDailyActiveDays *)tuesWedThursSat {
	SHDailyActiveDays *activeDays = [[SHDailyActiveDays alloc] init];
	[activeDays.weeklyActiveDays setDayOfWeek:0 to:NO];
	[activeDays.weeklyActiveDays setDayOfWeek:1 to:NO];
	[activeDays.weeklyActiveDays setDayOfWeek:2 to:YES];
	[activeDays.weeklyActiveDays setDayOfWeek:3 to:NO];
	[activeDays.weeklyActiveDays setDayOfWeek:4 to:YES];
	[activeDays.weeklyActiveDays setDayOfWeek:5 to:NO];
	[activeDays.weeklyActiveDays setDayOfWeek:6 to:YES];
	
	return activeDays;
}


-(SHDailyActiveDays * _Nonnull)sunMonThursFri {
	SHDailyActiveDays *activeDays = [[SHDailyActiveDays alloc] init];
	[activeDays.weeklyActiveDays setDayOfWeek:0 to:YES];
	[activeDays.weeklyActiveDays setDayOfWeek:1 to:YES];
	[activeDays.weeklyActiveDays setDayOfWeek:2 to:NO];
	[activeDays.weeklyActiveDays setDayOfWeek:3 to:NO];
	[activeDays.weeklyActiveDays setDayOfWeek:4 to:YES];
	[activeDays.weeklyActiveDays setDayOfWeek:5 to:YES];
	[activeDays.weeklyActiveDays setDayOfWeek:6 to:NO];
	
	return activeDays;
}

@end
