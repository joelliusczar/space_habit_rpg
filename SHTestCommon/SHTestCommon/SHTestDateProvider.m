//
//  SHTestDateProvider.m
//  SHTestCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHTestDateProvider.h"
@import SHDatetime;

@implementation SHTestDateProvider


-(NSDate*)date{
	return self.testDate;
}

-(NSInteger)localTzOffset {
	return 0;
}


-(struct SHDatetime)dateSHDt {
	struct SHDatetime dt;
	struct SHDatetime *dtp = [self.testDate SH_toSHDatetime];
	dt = *dtp;
	SH_freeSHDatetime(dtp);
	return dt;
}



@end
