//
//	SHDailyActivator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/13/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyActivator.h"
#import "SHConfig_Medium.h"
@import SHCommon;

@implementation SHDailyActivator


-(instancetype)initWithContext:(NSManagedObjectContext *)context
	withObjectId:(SHObjectIDWrapper *)objectID
{
	if(self = [super init]){
		_context = context;
		_objectID = objectID;
	}
	return self;
}


-(void)activate{
	NSAssert(self.objectID,@"Gotta have that object id");
	NSAssert(self.context,@"Gotta have that context");
	NSManagedObjectID *objectId = self.objectID.objectID;
	[self.context performBlock:^{
		NSError *err = nil;
		SHDaily *daily = (SHDaily *)[self.context existingObjectWithID:objectId error:&err];
		if(err) {
			@throw [NSException dbException:err];
		}
		SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
		SHConfig *config = [cm globalConfig];
		
		NSTimeInterval dayStart = config.userTodayStart.timeIntervalSince1970;
		NSTimeInterval lastActivation = daily.lastActivationDateTime.timeIntervalSince1970;
		if(dayStart > lastActivation) {
			daily.rollbackActivationDateTime = daily.lastActivationDateTime;
			daily.lastActivationDateTime = NSDate.date;
			if(self.activationAction) self.activationAction(YES,self.objectID);
		}
		else {
			daily.lastActivationDateTime = daily.rollbackActivationDateTime;
			daily.rollbackActivationDateTime = nil;
			if(self.activationAction) self.activationAction(NO,self.objectID);
		}
		[self.context performBlock:^{
			NSError *saveErr = nil;
			[self.context save:&saveErr];
			if(saveErr) {
				@throw [NSException dbException:saveErr];
			}
		}];
	}];
}


@end
