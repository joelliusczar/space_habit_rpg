//
//  DueDateItem.m
//  SHModels
//
//  Created by Joel Pridgen on 4/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDueDateItem.h"
#import "Daily+CoreDataClass.h"


@interface DueDateItem ()
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSManagedObjectID *objectId;
@end

@implementation DueDateItem


+(instancetype)newWithObjectID:(NSManagedObjectID*)objectId andContext:(NSManagedObjectContext*)context{
  DueDateItem *instance = [DueDateItem new];
  NSAssert(objectId.entity == Daily.entity,
    @"ObjectId must correspond to a Daily entity");
  instance.objectId = objectId;
  instance.context = context;
  return instance;
}

-(NSDate*)nextDueTime{
  __block NSDate *nextDueTime = nil;
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    nextDueTime = dd.nextDueTime;
  }];
  return nextDueTime;
}


-(NSInteger)maxDaysBefore{
  __block NSInteger max = 0;
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    max = dd.maxDaysBefore;
  }];
  return max;
}


-(NSString*)taskTitle{
  __block NSString *title = @"";
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    title = dd.taskTitle;
  }];
  return title;
}


-(NSMutableDictionary*)simpleMapable{
  __block NSMutableDictionary *sm = nil;
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    sm = dd.simpleMapable;
  }];
  return sm;
}


-(NSUInteger)reminderCount{
  __block NSUInteger count = 0;
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    count = dd.reminderCount;
  }];
  return count;
}

-(void)addNewReminder:(ReminderDTO *)reminder{
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    [dd addNewReminder:reminder];
  }];
}


-(ReminderDTO*)reminderAtIndex:(NSUInteger)index{
  __block ReminderDTO *reminder = nil;
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    reminder = [dd reminderAtIndex:index];
  }];
  return reminder;
}


-(void)removeReminderAtIndex:(NSUInteger)index{
  [self.context performBlockAndWait:^{
    id<P_DueDateItem> dd = [self.context objectWithID:self.objectId];
    [dd removeReminderAtIndex:index];
  }];
}
@end
