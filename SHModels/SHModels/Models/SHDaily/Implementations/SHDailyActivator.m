//
//	SHDailyActivator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/13/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyActivator.h"
#import "SHDailyEvent.h"
@import SHCommon;

@implementation SHDailyActivator


@synthesize dateProvider = _dateProvider;

-(NSObject<SHDateProviderProtocol>*)dateProvider{
	if(nil == _dateProvider) {
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}

-(instancetype)initWithObjectId:(SHContextObjectIDWrapper *)objectID
{
	if(self = [super init]){
		_objectID = objectID;
	}
	return self;
}


-(void)activate{
	NSAssert(self.objectID,@"Gotta have that object id");
	NSManagedObjectID *objectId = self.objectID.objectID;
	NSManagedObjectContext *context = self.objectID.context;
	[context performBlock:^{
		NSError *err = nil;
		SHDaily *daily = (SHDaily *)[context existingObjectWithID:objectId error:&err];
		if(err) {
			@throw [NSException dbException:err];
		}
		if(!daily.isActiveToday) return;
		/*
			if the task is something that the user wants to be able to complete
			before its due date, they should use a recuring todo
		*/
		
		NSInteger dayStartTime = 0;
		if(nil != daily.cycleStartTime) {
			dayStartTime = daily.cycleStartTime.integerValue;
		}
		else {
			dayStartTime = SHConfig.dayStartTime;
		}
		NSTimeInterval todayActivation = [self.dateProvider.date.dayStart
			dateByAddingTimeInterval:dayStartTime].timeIntervalSince1970;
		NSArray<SHDailyEvent*> *lastTwoActivations = [daily lastActivations: 2];
		SHDailyEvent *lastEvent = [lastTwoActivations silentGet:0];
		SHDailyEvent *rollbackToEvent = [lastTwoActivations silentGet:1];
		NSTimeInterval lastEventTimestamp = lastEvent.eventDatetime
			.timeIntervalSince1970 - lastEvent.tzOffset;
		if(todayActivation > lastEventTimestamp) {
			SHDailyEvent *activation = (SHDailyEvent *)[context newEntity:SHDailyEvent.entity];
			activation.eventDatetime = self.dateProvider.date;
			activation.tzOffset = (int32_t)self.dateProvider.localTzOffset;
			activation.event_daily = daily;
			daily.lastActivationDateTime = activation.eventDatetime;
			if(self.activationAction) self.activationAction(YES, self.objectID);
		}
		else {
			[context deleteObject:lastEvent];
			daily.lastActivationDateTime = rollbackToEvent.eventDatetime;
			if(self.activationAction) self.activationAction(NO, self.objectID);
		}
		NSError *saveErr = nil;
		[context save:&saveErr];
		if(saveErr) {
			@throw [NSException dbException:saveErr];
		}
	}];
}


@end
