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
#import "House.h"
#import "WeakLeash.h"
#import "GenericThing.h"
#import "C_Exp.h"

typedef id (^mbTest)(void);

@interface Experiments : NSObject
@property (assign,nonatomic) NSInteger stupidNum;
@property (strong,nonatomic) id<Protocus> proteboat;
@property (strong,nonatomic) UserOfProtocus *protocurious;
@property (strong,nonatomic) id<PossibleInvocationCockblock> cb;
@property (strong,nonatomic) House *houseOfMyOwn;
@property (strong,nonatomic) NSHashTable *hashSet;
@property (strong,nonatomic) WeakLeash *wl;
@property (strong,nonatomic) NSPointerArray *pointers;
@property (weak,nonatomic) House *designatedWeak;

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
-(void)hashStuffOne;
-(void)hashSTuffTwo;
-(void)hashStuffThree;
+(void)TestHashSet;
-(void)weak1;
-(void)weak2;
+(void)TestWeakStuff;
-(void)weakArray;
+(void)testWeakArray;
+(void)stackOverflowHashQuestion;
+(void)stackOverflowHashQuestionProp;
+(void)stackOverflowHashQuestion2;
+(void)expWithNonnullParams;
+(void)mapStuff;
+(void)blockStuff;
-(mbTest)blockMakeMemoryStuff;
+(void)blockTestMemoryStuff;
+(void)genericStuff;
+(void)recieveGenericStuff:(GenericThing<House *> *)thing;
+(void)readOnlyStuff;
+(void)nilPointerStuff;
+(void)doublePointerStuff;
+(void)constantStuff;
+(void)comparingThings;
+(void)encodeStuff;
+(void)retainStuff;
+(void)underbarWeakStuff;
+(void)castingBools;
+(void)pointerAddressStuff;
void cMakeHouses(void);
+(void)callCMakeHouses;
+(void)weekdays;
+(void)uintSubtract;
+(void)threeGenStuff;
+(void)classAsKey;
+(void)replaceCFuncs;
+(void)replaceStrat2;
+(void)tryHacked;
+(void)timeZoneStuff;
+(void)dateTimeStuff;
+(void)runC_Exp;
@end

#import "Experiments+Charlie.h"
