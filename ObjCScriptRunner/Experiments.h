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
#import "PossibleInvocationCockblock.h"

@interface Experiments : NSObject
@property (assign,nonatomic) NSInteger stupidNum;
@property (strong,nonatomic) id<Protocus> proteboat;
@property (strong,nonatomic) UserOfProtocus *protocurious;
@property (strong,nonatomic) id<PossibleInvocationCockblock> cb;
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
+(void)useImuteAsMute;
+(void)insertAtLast;
+(void)insertWhere;
+(void)ExpArrayStuff;
+(void)indexThatShit;
+(void)tryThatSubscriptAgain;
-(void)acceptsProtocolGuy:(id<PossibleInvocationCockblock>) pg;
+(void)invokesShit;
+(void)methodSignatureShit;
-(void)acceptsArgs:(NSInteger)num andStr:(NSString *)str and:(NSArray *)array;
+(void)protocolTestShit;
@end

#import "Experiments+Charlie.h"
