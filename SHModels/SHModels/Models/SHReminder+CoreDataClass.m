//
//  SHReminder+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHReminder+CoreDataClass.h"

@implementation SHReminder
-(void)copyFrom:(NSObject *)object{
  copyInstanceVar(object, self, @"daysBeforeDue");
  copyInstanceVar(object, self, @"reminderHour");
  copyInstanceVar(object, self, @"lastUpdateTime");
  copyInstanceVar(object, self, @"notificationID");
}
@end
