//
//	SHTodo+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTodo.h"

@implementation SHTodo
-(NSMutableDictionary *)mapable{
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:
		self.todoName,@"todoName"
		,[NSNumber numberWithDouble:self.utcDueDate.timeIntervalSince1970],@"dueDate"
		,[NSNumber numberWithDouble:self.utcEffectiveDate.timeIntervalSince1970 ],@"effectiveDate"
		,[NSNumber numberWithInt:self.userOrder],@"userOrder"
		, nil];
}
@end
