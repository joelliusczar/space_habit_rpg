//
//  TestHelpers.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <objc/runtime.h>

@interface TestHelpers : NSObject

+(void)resetCoreData:(NSManagedObjectContext *)context;
+(id)getPrivateValue:(id<NSObject>)obj ivarName:(NSString *)ivarName;
@end
