//
//  DailyHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Daily.h"

@interface DailyHelper : NSObject

+(BOOL)isDailyCompleteForTheDay:(Daily *)daily;

@end
