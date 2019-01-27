//
//  P_TimeUtilityStore.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_UtilityStore <NSObject>
@property (strong,nonatomic) NSCalendar *inUseCalendar;
@property (strong,nonatomic) NSLocale *inUseLocale;
@end
