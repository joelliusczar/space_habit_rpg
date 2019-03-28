//
//  Daily_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 3/26/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/P_CoreData.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "Daily_Medium.h"

@interface Daily_Medium()
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@end

@implementation Daily_Medium

+(instancetype)newWithSHData:(NSObject<P_CoreData> *)dataController{
  Daily_Medium *instance = [Daily_Medium new];
  instance.dataController = dataController;
  return instance;
}


-(Daily *)newDaily{
  return [self newDailyWithContext:nil];
}


-(Daily *)newDailyWithContext:(NSManagedObjectContext*)context{
  if(nil == context){
    context = self.dataController.mainThreadContext;
  }
  return (Daily *)[context newEntity:Daily.entity];
}

-(NSArray<NSSortDescriptor *> *)buildFetchDescriptors{
    NSSortDescriptor *sortByUserOrder = [[NSSortDescriptor alloc]
                                       initWithKey:@"customUserOrder" ascending:NO];
    NSSortDescriptor *sortByUrgency = [[NSSortDescriptor alloc]
                                       initWithKey:@"urgency" ascending:NO];
    NSSortDescriptor *sortByDifficulty = [[NSSortDescriptor alloc]
                                          initWithKey:@"difficulty" ascending:YES];
    return [NSArray arrayWithObjects:sortByUserOrder,sortByUrgency,sortByDifficulty, nil];
}


-(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart
withContext:(NSManagedObjectContext*)context{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1"
                           " AND (lastActivationTime = NULL"
                           " OR lastActivationTime < %@)"
                           ,todayStart];
    NSFetchRequest<Daily*> *request = Daily.fetchRequest;
    request.predicate = filter;
    request.sortDescriptors = [self buildFetchDescriptors];
    NSFetchedResultsController *resultsController = [context getItemFetcher:request];
    return resultsController;
}


-(NSFetchedResultsController *)getFinishedDailiesController:(NSDate *)todayStart
withContext:(NSManagedObjectContext*)context{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1 AND lastActivationTime >= %@",todayStart];
    NSArray *descriptors = @[[[NSSortDescriptor alloc]
                              initWithKey:@"lastActivationTime"
                              ascending:NO]];
    NSFetchRequest<Daily*> *request = Daily.fetchRequest;
    request.predicate = filter;
    request.sortDescriptors = descriptors;
    NSFetchedResultsController *resultsController = [context getItemFetcher:request];
    return resultsController;
}


@end
