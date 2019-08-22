//
//  SHNotificationHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/30/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;

@interface SHNotificationHelper : NSObject
+(UNMutableNotificationContent *)buildDefaultNotificationContent:(NSString *)notificationText
	userInfo:(NSDictionary *)info;
+(void)cleanUpSentReminders;
+(void)buildNotificationPermissionWrapped:(NSString *)notificationText
	notificationId:(NSString *)notificationId
	userInfo:(NSDictionary *)info;
+(void)addNewNotificationIfPossible:(NSString *)notificationText
	notificationId:(NSString *)notificationId
	userInfo:(NSDictionary *)info;
@end
