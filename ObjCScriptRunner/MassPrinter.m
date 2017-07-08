//
//  MassPrinter.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MassPrinter.h"

@implementation MassPrinter

+(void)outputAllLocaleFormatStringsToFile{
    
    NSString *fileContents = [MassPrinter readFileContentsFromDateHelperTest];
    NSArray<NSString *> *adjustedTests =
    [MassPrinter runRegexOnFileContents:fileContents];
    NSString *updatedContent = [adjustedTests componentsJoinedByString:@"\n"];
    NSLog(@"%@",updatedContent);
}


//+(void)doActualOutputWork:(NSString *)content{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSURL *documentsURL =
//    [fileManager URLsForDirectory:NSDocumentDirectory
//                        inDomains:NSUserDomainMask][0];
//    [fileManager create];
//}


+(NSString *)readFileContentsFromDateHelperTest{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *baseUrl =
    [fileManager URLsForDirectory:NSDocumentDirectory
                        inDomains:NSUserDomainMask][0];
    
    NSURL *unitTestsUrl =
    [baseUrl URLByAppendingPathComponent:@"spacehabitrpg/HabitRPG2Tests"
                             isDirectory:YES];
    
    NSURL *dateTestPath =
    [unitTestsUrl URLByAppendingPathComponent:@"DateHelperTest.m"];
    
    NSError *wrong = nil;
    NSStringEncoding *used = nil;
    
    NSString *fileContents = [NSString stringWithContentsOfURL:dateTestPath
                                                  usedEncoding:used error:&wrong];
    return fileContents;
}

+(NSArray *)runRegexOnFileContents:(NSString *)fileContents{
    NSString *expression =
    @"(testLocale = \\[NSLocale localeWithLocaleIdentifier:@\""
    "([a-zA-Z_]+)\"\\];)([\\n\\r\\t ]+XCTAssert(False|True)\\(testLocale"
    "\\.isUsing24HourFormat\\);)";
    
    NSError *wrong = nil;
    NSRegularExpression *regex =
    [NSRegularExpression
     regularExpressionWithPattern:expression
     options:NSRegularExpressionUseUnixLineSeparators error:&wrong];
    
    NSMutableArray<NSString *> *adjustedTests = [NSMutableArray array];
    
    [regex enumerateMatchesInString:fileContents
                            options:NSMatchingReportCompletion
                              range:NSMakeRange(0,fileContents.length)
                         usingBlock:
     ^(NSTextCheckingResult *result,NSMatchingFlags flags,BOOL *stop){
         NSString *localeId =
         [fileContents substringWithRange:[result rangeAtIndex:2]];
         NSLocale *locale = [NSLocale localeWithLocaleIdentifier:localeId];
         NSString *formatStr =
         [NSDateFormatter dateFormatFromTemplate:@"j"
                                         options:0 locale:locale];
         
         NSString *composedString = [NSString stringWithFormat:@"%@//%@%@",
                                     [fileContents substringWithRange:[result rangeAtIndex:1]]
                                     ,formatStr
                                     ,[fileContents substringWithRange:[result rangeAtIndex:3]]];
         
         [adjustedTests addObject: composedString];
                         }];
    
    return adjustedTests;
}

@end

