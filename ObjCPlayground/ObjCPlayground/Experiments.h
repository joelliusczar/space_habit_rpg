//
//	Experiments.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/10/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "Protocus.h"
#import "UserOfProtocus.h"
#import "PossibleInvocationCockblock.h"
#import "House.h"
#import "WeakLeash.h"
#import "GenericThing.h"
#import "C_Exp.h"
#import "WeakHolder.h"
#import "RefO.h"
#import "PtrHolder.h"
#import "FromCFunc.h"
#import "No_Arc/ArcLessObj.h"
#import "DumbDataSaver.h"
#import "CircleMaybe.h"
#import "SimpleDTO.h"
#import "Watcher.h"
#import "KVObject.h"
#import "ChildMan.h"


typedef WeakHolder Varholder;

typedef struct{
	int firstItem;
	int secondItem;
	int thirdItem;
	void *tstPtr;
} stupidStruct;

typedef id (^mbTest)(void);

typedef NSMutableArray<NSString *> SHStrArr;

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
+(void)replaceStrat2;
+(void)tryHacked;
+(void)timeZoneStuff;
+(void)dateTimeZoneStuff;
+(void)dateTimeStuff;
+(void)runC_Exp;
+(void)getWeekDayIndexes;
+(void)memSetErase;
+(void)memSizeStuff;
+(void)endianess;
+(void)autoreleaseJump;
+(void)passThruARP;
+(void)clsFromCFunc;
+(void)lostMems;
+(void)ptrExp;
+(void)forceNill;
+(void)testChildInsertSave;
+(void)testOrderednessCoreData;
+(void)dispatchQueueExp;
+(void)atomicExp;
+(void)privateInst;
+(void)ivarList;
+(void)reflectionCopy;
+(void)subStrC;
+(void)KVOStuff;
+(void)queuePossibleDeadlock;
+(void)tryingTheKVOverride;
+(void)testEntityAccessNoSave;
+(void)cfArrayStuff;
+(void)primitiveType;
+(void)postInsertion;
+(void)switchSemantics;
+(void)testPropCopy;
+(void)blockLocalObjRef;
+(void)loopThruIvars;
+(void)classCompare;
+(void)typeDefExps;
+(void)testReturnArray;
+(void)ptr2ptr;
@end

#import "Experiments+Charlie.h"
