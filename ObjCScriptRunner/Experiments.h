//
//  Experiments.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocus.h"
#import "UserOfProtocus.h"

@interface Experiments : NSObject
@property (assign,nonatomic) NSInteger stupidNum;
@property (strong,nonatomic) id<Protocus> proteboat;
@property (strong,nonatomic) UserOfProtocus *protocurious;
+(void)dateToJSON;
+(void)getAllIvar;
+(void)oversizedCast;
+(void)tryToUseObjectAsDict;
+(void)playWithAss;
-(void)callBravo;
+(void)playingWithNulls;
+(void)orderedSetFun;
+(void)pointToDict;
+(void)moreJSON;
+(void)protoItUp;
+(void)someNotStuff;
@end
