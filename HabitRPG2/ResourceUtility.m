//
//  ResourceUtility.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ResourceUtility.h"

@implementation ResourceUtility 

-(NSDictionary *)getPListDict:(NSString*)fileName withClassBundle:(nonnull Class)class{
    NSString *filePath = [[NSBundle bundleForClass:class] pathForResource:fileName ofType:@"plist"];
    NSAssert(filePath,@"file path for plist was null or empty");
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

-(NSArray *)getPListArray:(NSString*)fileName withClassBundle:(nonnull Class)class{
    NSString *filePath = [[NSBundle bundleForClass:class] pathForResource:fileName ofType:@"plist"];
    NSAssert(filePath,@"file path for plist was null or empty");
    return [NSArray arrayWithContentsOfFile:filePath];
}

@end
