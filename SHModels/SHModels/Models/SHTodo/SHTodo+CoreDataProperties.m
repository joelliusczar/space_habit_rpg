//
//  SHTodo+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTodo+CoreDataProperties.h"

@implementation SHTodo (CoreDataProperties)

+ (NSFetchRequest<SHTodo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHTodo"];
}

@dynamic difficulty;
@dynamic dueDate;
@dynamic effectiveDate;
@dynamic lastUpdateDateTime;
@dynamic note;
@dynamic todoName;
@dynamic urgency;
@dynamic userOrder;
@dynamic cat_todo;
@dynamic todo_itemReward;

@end
