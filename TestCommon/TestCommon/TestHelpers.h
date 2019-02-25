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
//#import <objc/objc-runtime.h>
#import <objc/message.h>

typedef void (*msg_send)(id,SEL);

@interface TestHelpers : NSObject

+(void)resetCoreData:(NSManagedObjectContext *)context;
+(void*)getPrivateValue:(id<NSObject>)obj ivarName:(NSString *)ivarName;
+(void)forceRelease:(id)obj;

+(void)setPrivateVar:(id)obj ivarName:(NSString *)ivarName
newVal:(id)newVal;

+(NSArray<NSString*>*)getMethodList:(id)obj;
@end
