//
//  NSLocale+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSLocale+Helper.h"
#import "constants.h"

@implementation NSLocale (Helper)

-(NSInteger)hourFormatMask{

    NSString *formatString =
    [NSDateFormatter dateFormatFromTemplate:@"j"
                                    options:0
                                     locale:self];
    NSLog(@"%@ %@",self.localeIdentifier,formatString);
    return [NSLocale hourMaskForGivenFormat:formatString];

}


+(NSInteger)hourMaskForGivenFormat:(NSString *)formatString{
    NSInteger hourFormatMask = 0;
    NSUInteger len = formatString.length;
    unichar searchable[len+1];
    [formatString getCharacters:searchable];
    
    for(NSUInteger i=0;i<len;i++){
        if(searchable[i]=='H'){
            hourFormatMask |= ZERO_BASED_24_HOUR;
        }
        if(searchable[i]=='h'){
            hourFormatMask |= ONE_BASED_12_HOUR;
        }
        if(searchable[i]=='K'){
            hourFormatMask |= ZERO_BASED_12_HOUR;
        }
        if(searchable[i]=='k'){
            hourFormatMask |= ONE_BASED_24_HOUR;
        }
    }
    return hourFormatMask;
}


+(BOOL)isMask24Hours:(NSInteger)mask{
    return (mask&ZERO_BASED_24_HOUR)|(mask&ONE_BASED_24_HOUR);
}


-(NSInteger)hourInLocaleFormat:(NSInteger)hour{
    return [NSLocale hour:hour inGivenFormatMask:self.hourFormatMask];
}


+(NSInteger)hour:(NSInteger)hour inGivenFormatMask:(NSInteger)hourMask{
    NSAssert(hour<24&&hour>=0,@"Hour is out of range");
    BOOL isUsing24Hours = [NSLocale isMask24Hours:hourMask];
    if(isUsing24Hours){
        //if for some reason both the zero based flag and one based flag
        //are present in the format string, I will default to zero base
        //just because...
        if(hourMask&ZERO_BASED_24_HOUR){
            return hour;
        }
        return hour+1;
    }
    else{
        //this will default to one based if there's a conflict
        //because that's what I use
        if((hourMask&ONE_BASED_12_HOUR)&&(hour==0||hour==12)){
            return 12;
            
        }
        return hour>=DAY_HALF?(hour%DAY_HALF):hour;
    }
}


-(BOOL)isUsing24HourFormat{
    NSInteger hourMask = self.hourFormatMask;
    return [NSLocale isMask24Hours:hourMask];
}


-(NSString *)AMSymbol{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = self;
    return formatter.AMSymbol;
}


-(NSString *)PMSymbol{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = self;
    return formatter.PMSymbol;
}


@end
