//
//  Experiments.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <objc/runtime.h>
#import "Experiments.h"
#import "House.h"
#import "House+Ass.h"
#import "Experiments+Bravo.h"
#import "UserOfProtocus.h"
#import "XPSideKick.h"
#import "ExpArray.h"
#import "Indexable.h"
#import "SelectorDict.h"
#import "CockblockShield.h"
#import "Holder.h"
#import "ExpNonNull.h"



@implementation Experiments
+(void)dateToJSON{
    NSDate *d1 = [NSDate date];
    NSError *wrong = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:d1 forKey:@"d1"];
    NSData *json = [NSJSONSerialization
                    dataWithJSONObject:dict
                    options:NSJSONWritingPrettyPrinted error:&wrong];
    NSString *jsonStr = [[NSString alloc]
                         initWithData:json
                         encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
}

+(void)getAllIvar{
    House *h = [[House alloc] init];
    h.count = 8;
    h.lamps = 19;
    h.couch = @"Green";

    unsigned int count;
    Ivar* ivars = class_copyIvarList(House.class,&count);
    for(int i=0;i<count;i++){

        NSString * str = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        NSLog(@"%@",[h valueForKey:str]);

    }
    free(ivars);
}

+(void)oversizedCast{
    NSInteger biggy = 1L<<31;
    int32_t i32 = (int32_t)biggy;
    NSLog(@"%ld",biggy);
    NSLog(@"%d",i32);
}


+(void)tryToUseObjectAsDict{
    House *h = [House new];
    [h setValue:@67 forKey:@"nonmember"];
    NSLog(@"%@",[h valueForKey:@"nonmember"]);
}


+(void)playWithAss{
    House.ghostNum = 19;
    NSLog(@"%ld",House.ghostNum);
    House.ghostNum = 23;
    NSLog(@"%ld",House.ghostNum);
}


-(void)callBravo{
    [self bravoMethod];
}


+(void)playingWithNulls{
    House *h = nil;
    [h returnsNothing];
    [h getFive];
}

+(void)orderedSetFun{
    House *h1 = [[House alloc] init];
    House *h2 = [[House alloc] init];
    NSOrderedSet *oSet = [[NSOrderedSet alloc] initWithObjects:h1,h1,h2,nil];
    NSLog(@"%ld",oSet.count);
    NSOrderedSet *oSet2 = [[NSOrderedSet alloc] initWithObjects:h1,h2,nil];
    NSLog(@"%ld",oSet2.count);
}


+(void)pointToDict{
    House *h = [House new];
    h.count = 19;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:h forKey:@"house"];
    House *h2 = (House *)dict[@"house"];
    h2.count = 23;
    NSLog(@"%ld",h.count);
}


+(NSMutableDictionary *)jsonStringToDict:(NSString *)jsonStr{
    NSError *err;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *jsonDict = [NSJSONSerialization
                                     JSONObjectWithData:jsonData
                                     options:NSJSONReadingMutableContainers error:&err];
    return jsonDict;
}

+(void)moreJSON{
    NSString* ALL_DAYS_JSON = @"{\"daysOfWeek\":{\"SUN\":1,\"MON\":1,\"TUE\":1,"
    "\"WED\":1,\"THR\":1,\"SAT\":1},\"daysOfMonth\":[],\"daysOfYear\":[],"
    "\"daysOfWeek_INV\":[],\"daysOfMonth_INV\":[],\"daysOfYear_INV\":[]}";
    id dict = [self jsonStringToDict:ALL_DAYS_JSON];
    NSMutableArray* arr = dict[@"daysOfMonth"];
    NSDictionary *small = [NSDictionary dictionaryWithObject:@4 forKey:@"ordinal"];
    NSDictionary *small2 = [NSDictionary dictionaryWithObject:@6 forKey:@"ordinal"];
    [arr addObject:small];
    [arr addObject:small2];
}

+(void)protoItUp{
    Experiments *exp = [[Experiments alloc] init];
    [exp.proteboat optionalius];
    [exp.proteboat usedAnyway];
    exp.proteboat = [XPSideKick proteThatBoat];
    [exp.proteboat usedAnyway];
    if([exp.proteboat respondsToSelector:@selector(optionalius)]){
        [exp.proteboat optionalius];
    }
    
}

+(void)someNotStuff{
    int a = 6;
    int b = 4;
    int c = 1;
    int d = a&b;
    d = !(a&b);
    d = a&c;
    d = !(a&c);
    int e = 7;
    int f = 0;
    int g = !e;
    g = !f;
}


+(void)useImuteAsMute{
    NSDictionary *d1 = [NSDictionary dictionaryWithObject:@"value1" forKey:@"key1"];
    NSMutableDictionary *d2 = (NSMutableDictionary *)d1;
    [d2 setObject:@"value2" forKey:@"key2"];
    NSArray *a1 = [NSArray arrayWithObject:@"item1"];
    NSMutableArray *a2 = (NSMutableArray *)a1;
    [a2 addObject:@"item2"];
}


+(void)insertAtLast{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,nil];
    [arr insertObject:@5 atIndex:4];
    [arr insertObject:@6 atIndex:7];
}


+(void)insertWhere{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,nil];
    [arr insertObject:@5 atIndex:1];
}


+(void)ExpArrayStuff{
    ExpArray *arr = [[ExpArray alloc] init];
    House *h = arr[0];
    arr.hause = nil;
    h = arr[0];
}

+(void)indexThatShit{
    Indexable *indexable = [[Indexable alloc]init];
    id result = indexable[5];
    result = indexable[@"Hello"];
}

+(void)tryThatSubscriptAgain{
    //SelectorDict *dict = [[SelectorDict alloc] init];
    //id result = dict[@selector(helloMethod)];
    //dict[@selector(helloMethod)] = @"Hello";
}

-(void)acceptsProtocolGuy:(id<PossibleInvocationCockblock>)pg{
    
}

+(void)invokesShit{
    Experiments *exp = [Experiments new];
    NSMethodSignature *sig = [exp methodSignatureForSelector:@selector(acceptsProtocolGuy:)];
    NSInvocation *invoker = [NSInvocation invocationWithMethodSignature:sig];
    NSObject *obj = [NSObject new];
    CockblockShield *shield = [CockblockShield new];
    [invoker setTarget:exp];
    [invoker setSelector:@selector(acceptsProtocolGuy:)];
    
    [invoker setArgument:&shield atIndex:2];
    [invoker invoke];
    
    [invoker setArgument:&obj atIndex:2];
    [invoker invoke];
}

-(void)acceptsArgs:(NSInteger)num andStr:(NSString *)str and:(NSArray *)array{}


+(void)methodSignatureShit{
//    Experiments *exp = [Experiments new];
//    Method m = class_getInstanceMethod(exp.class,@selector(acceptsProtocolGuy:));
//    struct objc_method_description *s = method_getDescription(m);
    
}

-(void)hashStuffOne{
    self.hashSet = [NSHashTable weakObjectsHashTable];
    self.houseOfMyOwn = [[House alloc] init];
    self.houseOfMyOwn.lamps = 7;
    [self.hashSet addObject:self.houseOfMyOwn];
}

-(void)hashSTuffTwo{
    House *h0 = [self.hashSet anyObject];
    h0 = nil;
    self.houseOfMyOwn = nil;
}


-(void)hashStuffThree{
    House *h1 = [self.hashSet anyObject];
    NSLog(@"%@",h1);
}

+(void)TestHashSet{
    Experiments *exp = [Experiments new];
    [exp hashStuffOne];
    [exp hashSTuffTwo];
    NSLog(@"count: %ld",exp.hashSet.count);
}

-(void)weak1{
    self.houseOfMyOwn = [House new];
    self.houseOfMyOwn.lamps = 19;
    self.wl = [WeakLeash new];
    self.wl.weakHouse = self.houseOfMyOwn;
    self.houseOfMyOwn = nil;
    
}

-(void)weak2{}

+(void)TestWeakStuff{
    Experiments *exp = [Experiments new];
    [exp weak1];
}


-(void)weakArray{
    self.pointers = [NSPointerArray weakObjectsPointerArray];
    self.houseOfMyOwn = [House new];
    self.houseOfMyOwn.lamps = 7;
    House *h0 = [House new];
    [self.pointers addPointer:(__bridge void * _Nullable)(self.houseOfMyOwn)];
    [self.pointers addPointer:(__bridge void * _Nullable)(h0)];
    self.houseOfMyOwn = nil;
    h0 = nil;
}


+(void)testWeakArray{
    Experiments *exp = [Experiments new];
    [exp weakArray];
}

+(void)stackOverflowHashQuestion{
    NSHashTable *hashTable = [NSHashTable weakObjectsHashTable];
    House *object = [[House alloc] init];
    [hashTable addObject:object];
    NSLog(@"%@",[hashTable anyObject]);
    NSLog(@"%ld",hashTable.count);
    
    object = nil;
    NSLog(@"%@",@"after dealloc hopefully");
    NSLog(@"%@",[hashTable anyObject]);
    int i = 0;
    while([hashTable anyObject] && ++i<100000){};
    NSLog(@"%ld",hashTable.count);
}


+(void)stackOverflowHashQuestionProp{
    NSLog(@"strong property");
    Experiments *exp = [Experiments new];
    exp.houseOfMyOwn = [[House alloc] init];
    NSHashTable *hashTable = [NSHashTable weakObjectsHashTable];
    [hashTable addObject:exp.houseOfMyOwn];
    NSLog(@"%@",[hashTable anyObject]);
    exp.houseOfMyOwn = nil;
    NSLog(@"%@",[hashTable anyObject]);
    
}

+(void)stackOverflowHashQuestion2{
    NSHashTable *hashTable = [NSHashTable weakObjectsHashTable];
    House *object = [[House alloc] init];
    House *object2 = [House new];
    [hashTable addObject:object];
    [hashTable addObject:object2];
    @autoreleasepool{
        [hashTable containsObject:object];
    }
    object = nil;
    object2 = nil;
}


+(void)expWithNonnullParams{
//    NSLog(@"%d",[ExpNonNull cNonNull:nil]);
//    ExpNonNull *enn = [[ExpNonNull alloc] init];
//    NSLog(@"%d",[enn instanceNonNulls:nil]);
//    House *h0 = [ExpNonNull cRetNonNull];
//    h0 = [enn instanceRetNonNulls];
    
}

+(void)mapStuff{
    NSMapTable *map = [NSMapTable weakToStrongObjectsMapTable];
    [map setObject:@"Hello" forKey:@"key1"];
    
    NSString *str = [map objectForKey:@"key1"];
    NSLog(@"%@",str);
}

+(void)blockStuff{
    int t = 7;
    void (^tb)() = ^void(){
        NSLog(@"%d",t);
    };
    
    t += 2;
    tb();
    t++;
    tb();

}

-(void)privateSetWeak{
    House *h = [[House alloc] init];
    _designatedWeak = h;
    NSLog(@"In private %@",_designatedWeak);
}


-(void)privateSetWeak2{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-unsafe-retained-assign"
    House *h = [[House alloc] init];
    h.h = [[House alloc] init];
    self.designatedWeak = h.h;
    NSLog(@"In private %@",self.designatedWeak);
    #pragma clang diagnostic pop
}


-(mbTest)blockMakeMemoryStuff{
    NSLog(@"making block");
    House *h = [[House alloc] init];
    _designatedWeak = h;
    h.couch = @"Test hello";
    mbTest blk = ^id(){
        NSLog(@"%@",h.couch);
        return h;
    };
    return blk;
}


+(void)blockTestMemoryStuff{
    Experiments *exp = [[Experiments alloc] init];
    [exp privateSetWeak];
    NSLog(@"%@",exp.designatedWeak?@"Weak exists":@"weak does not exist");
    mbTest blk = [exp blockMakeMemoryStuff];
    NSLog(@"%@",exp.designatedWeak?@"Weak exists":@"weak does not exist");
    NSLog(@"block created");
    blk();
}
    
@end
