//
//	SHReminder+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHReminder.h"
@import SHCommon;

@implementation SHReminder
-(void)copyFrom:(NSObject *)object{
	shCopyInstanceVar(object, self, @"daysBeforeDue");
	shCopyInstanceVar(object, self, @"reminderHour");
	shCopyInstanceVar(object, self, @"lastUpdateTime");
	shCopyInstanceVar(object, self, @"notificationID");
}
@end
