//
//  SHTeapot+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTeapot+CoreDataProperties.h"

@implementation SHTeapot (CoreDataProperties)

+ (NSFetchRequest<SHTeapot *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHTeapot"];
}

@dynamic timestampStart;
@dynamic type;
@dynamic timerLength;
@dynamic timestampEnd;
@dynamic cat_teapot;

@end
