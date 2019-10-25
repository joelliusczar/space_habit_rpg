//
//	SHDailySubTask+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDailySubTask.h"
@import SHCommon;

@implementation SHDailySubTask


-(NSMutableDictionary*)mappable{
	return [NSDictionary objectToDictionary:self];
}

-(void)copyFrom:(NSObject *)object{
	shCopyInstanceVar(object,self,@"activeDaysHash");
	shCopyInstanceVar(object,self,@"dailySubTaskName");
	shCopyInstanceVar(object,self,@"difficulty");
	shCopyInstanceVar(object,self,@"lastActivationDateTime");
	shCopyInstanceVar(object,self,@"lastUpdateDateTime");
	shCopyInstanceVar(object,self,@"rate");
	shCopyInstanceVar(object,self,@"urgency");
	}

@end
