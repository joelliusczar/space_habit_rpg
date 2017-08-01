//
//  NotificationHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/30/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;

@interface NotificationHelper : NSObject
+(UNMutableNotificationContent *)buildDefaultNotificationContent:(NSString *)notificationText;
+(void)cleanUpSentReminders;
+(void)buildNotificationPermissionWrapped:(NSString *)notificationText;
+(void)addNewNotificationIfPossible:(NSString *)notificationText;
@end
