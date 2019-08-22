//
//	NSLocale+Helper.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/5/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (Helper)
@property (readonly,nonatomic) BOOL isUsing24HourFormat;
@property (readonly,nonatomic) NSInteger hourFormatMask;
@property (readonly,nonatomic) NSString* AMSymbol;
@property (readonly,nonatomic) NSString* PMSymbol;
+(NSInteger)hourMaskForGivenFormat:(NSString *)formatString;
-(NSInteger)hourInLocaleFormat:(NSInteger)hour;
+(NSInteger)hour:(NSInteger)hour inGivenFormatMask:(NSInteger)hourMask;
@end
