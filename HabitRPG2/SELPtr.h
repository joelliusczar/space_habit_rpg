//
//  SELWrap.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SELPtr : NSObject<NSCopying>
@property (readonly,assign,nonatomic) SEL selector;
+(instancetype)sel:(SEL)selector;
@end


