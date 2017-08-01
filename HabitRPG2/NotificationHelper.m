//
//  NotificationHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/30/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NotificationHelper.h"
#import "constants.h"
@import UIKit;


@implementation NotificationHelper

+(UNMutableNotificationContent *)buildDefaultNotificationContent:(NSString *)notificationText{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Reminder:";
    content.body = notificationText;
    content.badge = @1;
    content.sound = UNNotificationSound.defaultSound;
    content.categoryIdentifier = NOTIFY_CAT_ID;
    return content;
}


+(void)cleanUpSentReminders{
    UNUserNotificationCenter *center = [UNUserNotificationCenter
                                        currentNotificationCenter];
    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> *notifications){
        NSLog(@"delivered: %ld",notifications.count);
        for(UNNotification *notification in notifications){
            NSString *noticeText = notification.request.content.body;
            [self addNewNotificationIfPossible:noticeText];
        }
        [center removeAllDeliveredNotifications];
        UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
    }];
    
    
}


+(void)addNewNotificationIfPossible:(NSString *)notificationText{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:
     ^(UNNotificationSettings *settings){
         if(settings.authorizationStatus == UNAuthorizationStatusNotDetermined){
             [self buildNotificationPermissionWrapped:notificationText];
         }
         else if(settings.authorizationStatus == UNAuthorizationStatusAuthorized){
             [self buildNotificationPermissionWrapped:notificationText];
         }
     }];
}

+(void)buildNotificationPermissionWrapped:(NSString *)notificationText{
    UNUserNotificationCenter *center = [UNUserNotificationCenter
                                        currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert
    |UNAuthorizationOptionBadge
    |UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:
     ^(BOOL granted,NSError *wrong){
         if(granted){
             [self buildNotification:notificationText];
         }
     }];
}

+(void)buildNotification:(NSString *)notificationText{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [NotificationHelper
                                             buildDefaultNotificationContent:
                                             notificationText];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:60
                                                  repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest
                                      requestWithIdentifier:@"Remider"
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
