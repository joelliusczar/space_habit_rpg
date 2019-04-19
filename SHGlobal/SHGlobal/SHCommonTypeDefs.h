//
//  SHCommonTypeDefs.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef CommonTypeDefs_h
#define CommonTypeDefs_h

#import <Foundation/Foundation.h>

typedef void (*shSetter)(id,SEL,id);
typedef void (^shWrapReturnVoid)(void);
typedef BOOL (^shWrapReturnBool)(void);

#define unixTime(dtObj) dtObj.timeIntervalSince1970

#endif
