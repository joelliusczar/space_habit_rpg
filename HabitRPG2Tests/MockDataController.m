//
//  MockDataController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MockDataController.h"
#import "Daily+CoreDataClass.h"
#import "Habit+CoreDataClass.h"
#import "Todo+CoreDataClass.h"
#import "Good+CoreDataClass.h"
#import "Hero+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "Zone+CoreDataClass.h"
#import "Monster+CoreDataClass.h"
#import "DataInfo+CoreDataClass.h"


@implementation MockDataController
    
    @synthesize isTesting = _isTesting;
    @synthesize disabledSaveResult = _disabledSaveResult;
    @synthesize disableSave = _disableSave;
    @synthesize context = _context;
    
    @synthesize userData = _userData;
    -(OnlyOneEntities *)userData{
        if(!_userData){
            _userData = [[OnlyOneEntities alloc] initWithDataController:self];
        }
        return _userData;
    }
    
    @synthesize mockContext = _mockContext;
    -(NSMutableDictionary<NSString *,NSMutableArray *> *)mockContext{
        if(!_mockContext){
            _mockContext = [NSMutableDictionary dictionary];
        }
        return _mockContext;
    }
    
    -(instancetype)initWithDBFileName:(NSString *)dbFileName{
        if(self = [super init]){}
        return self;
    }
    
    -(NSManagedObject *)constructEmptyEntity:(NSString *)entityType{
        if([entityType isEqualToString: DAILY_ENTITY_NAME]){
            return [[Daily alloc] init];
        }
        if([entityType isEqualToString: HABIT_ENTITY_NAME]){
            return [[Habit alloc] init];
        }
        if([entityType isEqualToString: TODO_ENTITY_NAME]){
            return [[Todo alloc] init];
        }
        if([entityType isEqualToString: GOOD_ENTITY_NAME]){
            return [[Good alloc] init];
        }
        if([entityType isEqualToString: HERO_ENTITY_NAME]){
            return [[Hero alloc] init];
        }
        if([entityType isEqualToString: SETTINGS_ENTITY_NAME]){
            return [[Settings alloc] init];
        }
        if([entityType isEqualToString: ZONE_ENTITY_NAME]){
            return [[Zone alloc] init];
        }
        if([entityType isEqualToString: MONSTER_ENTITY_NAME]){
            return [[Monster alloc] init];
        }
        if([entityType isEqualToString: DATA_INFO_ENTITY_NAME]){
            return [[DataInfo alloc] init];
        }
        [NSException raise:@"Invalid arg" format:@"argument is invalid"];
        return nil;
    }
    
    -(NSManagedObject *)getItem:(NSString *)entityName predicate:(NSPredicate *)filter sortBy:(NSArray<NSSortDescriptor *> *)sortAttrs{
        return (NSManagedObject *)self.mockContext[entityName][self.testCaseIndex];
    }
    
    -(NSManagedObject *)getItemWithRequest:(NSFetchRequest *)fetchRequest predicate:(NSPredicate *)filter sortBy:(NSArray<NSSortDescriptor *> *)sortArray
    {
        return (NSManagedObject *)self.mockContext[fetchRequest.entityName][self.testCaseIndex];
    }
    
    -(NSFetchedResultsController *)getItemFetcher:(NSString *)entityName predicate:(NSPredicate *)filter sortBy:(NSArray *)sortAttrs
    {
        //not sure what I'm doing with this yet
        return nil;
    }
    
    -(void)softDeleteModel:(NSManagedObject *)model{
        model = nil;
    }
    
    -(BOOL)save{
        if(self.disableSave){
            return self.disabledSaveResult;
        }
        return true;
    }
    
    -(BOOL)deleteModelAndSave:(NSManagedObject *)model{
        [self softDeleteModel:model];
        return [self save];
    }
    
    -(void)deleteAllRecords{
        //not needed in testing
    }
    
@end
