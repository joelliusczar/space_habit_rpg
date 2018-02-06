//
//  CommonTypeDefs.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (*setter)(id,SEL,id);

#define unixTime(dtObj) dtObj.timeIntervalSince1970
