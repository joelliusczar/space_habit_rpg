//
//  TestHelpers.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
@import CoreData;
#import <objc/runtime.h>
#import <objc/message.h>

typedef void (*msg_send)(id,SEL);

@interface TestHelpers : NSObject


+(void*)getPrivateValue:(id<NSObject>)obj ivarName:(NSString *)ivarName;
+(void)forceRelease:(id)obj;

+(void)setPrivateVar:(id)obj ivarName:(NSString *)ivarName
 newVal:(id)newVal;

+(NSArray<NSString*>*)getMethodList:(id)obj;
+(NSArray<NSString*>*)getMethodListOfClass:(Class)cls;
+(NSArray<NSString*>*)getIvarListOfClass:(Class)cls;

@end
