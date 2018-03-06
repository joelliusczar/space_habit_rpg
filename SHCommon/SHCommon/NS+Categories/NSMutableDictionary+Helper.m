//
//  NSMutableDictionary+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSMutableDictionary+Helper.h"

@implementation NSMutableDictionary (Helper)


-(id)getWithKey:(id)key OrCreateFromBlock:(id (^)(void))creator{
    id value=self[key];
    if(value){
        return value;
    }
    value=creator();
    self[key]=value;
    return value;
}

+(NSString *_Nonnull)dictToString:(NSDictionary *_Nonnull)dict{
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dict
                        options:NSJSONWritingPrettyPrinted error:&err];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(NSMutableDictionary *_Nonnull)jsonStringToDict:(NSString *_Nonnull)jsonStr{
    NSError *err;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *jsonDict = [NSJSONSerialization
                                     JSONObjectWithData:jsonData
                                     options:NSJSONReadingMutableContainers error:&err];
    return jsonDict;
}

@end
