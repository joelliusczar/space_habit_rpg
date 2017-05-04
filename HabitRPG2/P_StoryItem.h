//
//  P_StoryItem.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_StoryItem <NSObject>
@property (nonatomic,strong,readonly) NSString *fullName;
@property (nonatomic,strong,readonly) NSString *synopsis;
@property (nonatomic,readonly) NSString *headline;
@end
