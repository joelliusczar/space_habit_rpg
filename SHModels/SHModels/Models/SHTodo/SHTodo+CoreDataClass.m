//
//  SHTodo+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTodo+CoreDataClass.h"

@implementation SHTodo
-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.todoName,@"todoName"
            ,[NSNumber numberWithDouble:self.dueDate.timeIntervalSince1970],@"dueDate"
            ,[NSNumber numberWithDouble:self.effectiveDate.timeIntervalSince1970 ],@"effectiveDate"
            ,[NSNumber numberWithInt:self.userOrder],@"userOrder"
            , nil];
}
@end
