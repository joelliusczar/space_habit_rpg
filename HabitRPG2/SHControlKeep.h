//
//  SHControlArray.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHView.h"

#define takeKey(methodName) [SELPtr sel:@selector(methodName)]
/*
 definition: subject is the control that has a reference to object
 subject does action to object
 object/subject is also not used completely consistently, 
 for example, objectAtIndexedSubscript is dealing with my 'subjects'
*/

@interface SHControlKeep : NSObject
@property (readonly,nonatomic) NSUInteger count;
-(id)objectAtIndexedSubscript:(NSUInteger)idx;
//-(id)objectForKeyedSubscript:(SELPtr *)key;
-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key;
-(BOOL)addSubjectToActionSet:(id)subject withKey:(SELPtr *)key;
@end


typedef id (^LazyLoadBlock)(SHControlKeep *);

@interface SHControlKeep()
-(void)addLoaderBlock:(LazyLoadBlock)loaderBlock;
@end
