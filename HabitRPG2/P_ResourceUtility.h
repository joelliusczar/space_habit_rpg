//
//  P_ResourceUtility.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_ResourceUtility <NSObject>
-(nonnull NSDictionary*)getPListDict:(nonnull NSString*)fileName withClassBundle:(nonnull Class)class;
@end
