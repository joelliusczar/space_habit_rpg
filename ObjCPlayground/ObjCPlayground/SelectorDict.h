//
//	SelectorDict.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectorDict : NSObject
-(id)objectForKeyedSubscript:(Class)key;
-(void)setObject:(id)obj forKeyedSubscript:(Class)key;
-(void)helloMethod;
@property (strong,nonatomic) id it;
@end
