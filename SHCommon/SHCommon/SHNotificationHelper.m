//
//  SHNotificationHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/30/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHNotificationHelper.h"
#import "SHConstants.h"

@import UIKit;

@implementation SHNotificationHelper

+(UNMutableNotificationContent *)buildDefaultNotificationContent:(NSString *)notificationText
	userInfo:(NSDictionary *)info
{
	(void)info;
	UNMutableNotificationContent *content = [UNMutableNotificationContent new];
	content.title = @"Reminder:";
	content.body = notificationText;
	content.badge = @1;
	content.sound = UNNotificationSound.defaultSound;
	content.categoryIdentifier = SH_NOTIFY_CAT_ID;
	return content;
}


+(void)cleanUpSentReminders{
	UNUserNotificationCenter *center = [UNUserNotificationCenter
		currentNotificationCenter];
	[center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> *notifications){
		for(UNNotification *notification in notifications){
			NSString *noticeText = notification.request.content.body;
			
			[self addNewNotificationIfPossible:noticeText
				notificationId:notification.request.identifier
				userInfo:notification.request.content.userInfo];
		}
		[center removeAllDeliveredNotifications];
		dispatch_sync(dispatch_get_main_queue(),^{
			UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
		});
	}];
	
}


+(void)addNewNotificationIfPossible:(NSString *)notificationText
	notificationId:(NSString *)notificationId
	userInfo:(NSDictionary *)info
{
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	[center getNotificationSettingsWithCompletionHandler:
	 ^(UNNotificationSettings *settings){
		 if(settings.authorizationStatus == UNAuthorizationStatusNotDetermined){
			 [self buildNotificationPermissionWrapped:notificationText
					notificationId:notificationId
					userInfo:info];
		 }
		 else if(settings.authorizationStatus == UNAuthorizationStatusAuthorized){
			 [self buildNotificationPermissionWrapped:notificationText
					notificationId:notificationId
					userInfo:info];
		 }
	 }];
}


+(void)buildNotificationPermissionWrapped:(NSString *)notificationText
	notificationId:(NSString *)notificationId
	userInfo:(NSDictionary *)info
{
	UNUserNotificationCenter *center = [UNUserNotificationCenter
										currentNotificationCenter];
	UNAuthorizationOptions options = UNAuthorizationOptionAlert
	|UNAuthorizationOptionBadge
	|UNAuthorizationOptionSound;
	[center requestAuthorizationWithOptions:options completionHandler:
	 ^(BOOL granted,NSError *wrong){
		 (void)wrong;
		 if(granted){
			 [self buildNotification:notificationText notificationId:notificationId
							userInfo:info];
		 }
	 }];
}

+(void)buildNotification:(NSString *)notificationText
	notificationId:(NSString *)notificationId
	userInfo:(NSDictionary *)info
{
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	UNMutableNotificationContent *content = [SHNotificationHelper
											 buildDefaultNotificationContent:
											 notificationText userInfo:info];
	UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
												  triggerWithTimeInterval:60
												  repeats:NO];
	UNNotificationRequest *request = [UNNotificationRequest
									  requestWithIdentifier:notificationId
									  content:content
									  trigger:trigger];
	[center addNotificationRequest:request withCompletionHandler:
		^(NSError *error){
			if(error){
				NSLog(@"%@",error);
			}
		}];
}

@end
