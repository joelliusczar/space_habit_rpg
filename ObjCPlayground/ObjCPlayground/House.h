//
//	House.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/10/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@interface House : NSObject
@property (strong,nonatomic) NSString *couch;
@property (assign,nonatomic) NSInteger count;
@property (assign,nonatomic) NSInteger lamps;
@property (weak,nonatomic) NSHashTable *hs;
@property (weak,nonatomic) House *h;
-(void)returnsNothing;
-(NSInteger)getFive;
@end


@interface FakeHouse : NSObject
@property (strong,nonatomic) NSString *couch;
@property (assign,nonatomic) NSInteger count;
@property (assign,nonatomic) NSInteger lamps;
@property (weak,nonatomic) NSHashTable *hs;
@property (weak,nonatomic) House *h;
-(void)returnsNothing;
-(NSInteger)getFive;
@end

#import "House+Things.h"
