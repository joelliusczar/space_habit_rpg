//
//	Experiments.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/10/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

//#define outsideFunc() r_outside()
//#define insideFunc() r_inside()

#import <objc/runtime.h>
#import <objc/objc-runtime.h>
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
#import "ReadOonly.h"
#import "EncodeStuff.h"
#import "Retainer.h"
#import <limits.h>
#import "Pool.h"
#import "Lake.h"
#import "Ocean.h"
#import "PureCBaby.h"
#import "House+Hacked.h"

@import SHModels;
@import SHCommon;
@import SHTestCommon;
@import SHDatetime;
//#import <SHTestCommon/TestHelpers.h>
#import <malloc/malloc.h>






void r_outside(){
	NSLog(@"Outside replaced");
}

void r_inside(){
	NSLog(@"Inside replaced");
}

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
	for(uint i=0;i<count;i++){

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
	NSLog(@"%d",d);
	int e = 7;
	int f = 0;
	int g = !e;
	g = !f;
	NSLog(@"%d",g);
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
	NSLog(@"%@",h);
}

+(void)indexThatShit{
	Indexable *indexable = [[Indexable alloc]init];
	id result = indexable[5];
	result = indexable[@"Hello"];
	NSLog(@"%@",result);
}

+(void)tryThatSubscriptAgain{
	//SelectorDict *dict = [[SelectorDict alloc] init];
	//id result = dict[@selector(helloMethod)];
	//dict[@selector(helloMethod)] = @"Hello";
}

-(void)acceptsProtocolGuy:(id<PossibleInvocationCockblock>)pg{
	(void)pg;
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

-(void)acceptsArgs:(NSInteger)num andStr:(NSString *)str and:(NSArray *)array{
	(void)num;
	(void)str;
	(void)array;
}


+(void)methodSignatureShit{
//	Experiments *exp = [Experiments new];
//	Method m = class_getInstanceMethod(exp.class,@selector(acceptsProtocolGuy:));
//	struct objc_method_description *s = method_getDescription(m);
	
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
//	NSLog(@"%d",[ExpNonNull cNonNull:nil]);
//	ExpNonNull *enn = [[ExpNonNull alloc] init];
//	NSLog(@"%d",[enn instanceNonNulls:nil]);
//	House *h0 = [ExpNonNull cRetNonNull];
//	h0 = [enn instanceRetNonNulls];
	
}

+(void)mapStuff{
	NSMapTable *map = [NSMapTable weakToStrongObjectsMapTable];
	[map setObject:@"Hello" forKey:@"key1"];
	
	NSString *str = [map objectForKey:@"key1"];
	NSLog(@"%@",str);
}

+(void)blockStuff{
	int t = 7;
	void (^tb)(void) = ^void(){
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


+(void)genericStuff{
	GenericThings<House *,FakeHouse *> *gt = [[GenericThings alloc] init];
	gt.thing = [[House alloc] init];
	gt.thing2 = [[FakeHouse alloc] init];
	[Experiments recieveGenericStuff:gt];
}


+(void)recieveGenericStuff:(GenericThing<House *> *)thing{
	NSLog(@"%@",[thing isKindOfClass:GenericThings.class]?@"It is Things":@"It's only a thing");
	GenericThings *gt = (GenericThings *)thing;
	NSLog(@"%@",gt.thing2);
}


+(void)readOnlyStuff{
	ReadOonly *ro = [[ReadOonly alloc] init];
	//ro.rudy = 7;
	setRoody(7,ro);
	NSLog(@"%ld",ro.rudy);
}


+(void)nilPointerStuff{
	House *h = [[House alloc] init];
	House *h2 = h.h;
	h2 = [[House alloc] init];
	NSLog(@"%@",h.h);
	NSLog(@"%@",h2);
}


+(void)doublePointerStuff{
	House *h = [[House alloc] init];
	(void)h;
	//House **h2;
	
}


+(void)constantStuff{
	NSLog(@"sizeof(NSUInteger) : %ld",sizeof(NSUInteger));
	NSLog(@"CHAR_BIT : %d",CHAR_BIT);
}


+(void)comparingThings{
	SEL a1 = @selector(constantStuff);
	SEL a2 = @selector(constantStuff);
	SEL b1 = @selector(doublePointerStuff);
	
	NSLog(@"%@",a1==a2?@"a1 and a2 equal":@"a1 and a2 not equal");
	NSLog(@"%@",a1==b1?@"a1 and b1 equal":@"a1 and b1 not equal");
}

+(void)encodeStuff{
	EncodeStuff<House *> *es = [[EncodeStuff alloc] init];
	House *h = [[House alloc] init];
	NSLog(@"Type is: %@",[es whatItDo:h]);
	
	EncodeStuff<mbTest> *es2 = [[EncodeStuff alloc] init];
	mbTest mb = ^id(){
		return [[House alloc] init];
	};
	NSLog(@"Type is: %@",[es2 whatItDo:mb]);
}


+(void)retainStuff{
	Retainer *r1 = [[Retainer alloc] init];
	Retainer *r2 = [[Retainer alloc] init];
	r1.r = r2;
	r2.r = r1;
	r1 = nil;
	r2 = nil;
}


+(void)underbarWeakStuff{
	House *h1 = [[House alloc] init];
	House * __weak h2 = h1;
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	dict[@"key1"] = h2;
	h1 = nil;
	NSLog(@"end underbarWeakStuff");
}


+(void)castingBools{
	int s = 8;
	BOOL b = s;
	BOOL b2 = NO;
	NSUInteger ui = b;
	NSUInteger ui2 = b2;
	NSInteger i = b;
	NSInteger i2 = b2;
	(void)ui;(void)ui2;(void)i;(void)i2;
}

+(void)pointerAddressStuff{
	House *h = [[House alloc] init];
	NSUInteger addr = (NSUInteger)&h;
	NSLog(@"Address: %lu", addr);
}

void cMakeHouses(void){
	House *h = [[House alloc] init];
	[h returnsNothing];
}


+(void)callCMakeHouses{
	cMakeHouses();
}

+(void)weekdays{
	NSCalendar *cal = NSCalendar.currentCalendar;
	NSInteger wdnum = [cal component:NSCalendarUnitWeekday fromDate:[NSDate date]];
	wdnum = [cal component:NSCalendarUnitWeekdayOrdinal fromDate:[NSDate date]];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSArray<NSString *> *days = formatter.shortWeekdaySymbols;
	days = formatter.weekdaySymbols;
	days = formatter.standaloneWeekdaySymbols;
	days = formatter.veryShortWeekdaySymbols;
}

NSString *convertCharToBin(unsigned char input){
	char binRep[9] = "00000000";
	int idx = 0;
	while(input > 0){
		if(input & 1){
			binRep[idx] = '1';
		}
		idx++;
		input >>= 1;
	}
	for(int i = 0; i < 8/2;i++){
		char tmp = binRep[i];
		binRep[i] = binRep[7 - i];
		binRep[7 - i] = tmp;
	}
	return [NSString stringWithUTF8String:binRep];
}

+(void)uintSubtract{
	unsigned char a = UCHAR_MAX;
	char b = CHAR_MAX;
	a++;
	b++;
	b <<= 1;
	NSLog(@"a bin: %@ - dec: %d",convertCharToBin(a),a);
	NSLog(@"b bin: %@ - dec: %d",convertCharToBin(b),b);
	a = CHAR_MAX;
	a+=5;
	unsigned char c = CHAR_MAX;
	NSLog(@"c max bin: %@ - dec: %d",convertCharToBin(c),c);
	c+=2;
	unsigned char d = a - c;
	unsigned char c2 = -1*c;
	 NSLog(@"c +2 bin: %@ - dec: %d",convertCharToBin(c),c);
	NSLog(@"c *-1 bin: %@ - dec: %d",convertCharToBin(c2),c2);
	NSLog(@"d bin: %@ - dec: %d",convertCharToBin(d),d);
	char e = -1*((char)c);
	unsigned char h = a + e;
	NSLog(@"e bin: %@ - dec: %d",convertCharToBin(e),e);
	NSLog(@"h bin: %@ - dec: %d",convertCharToBin(h),h);
	char f = CHAR_MIN;
	char g = -1*f;
	NSLog(@"g bin: %@ - dec: %d",convertCharToBin(g),g);
	unsigned char i = 6;
	unsigned char j = -1*i;
	NSLog(@"j bin: %@ - dec: %d",convertCharToBin(j),j);
}

+(void)threeGenStuff{
	Pool *p0 = [[Pool alloc] init];
	Pool *p1 = [[Pool alloc] init];
	Lake *l0 = [[Lake alloc] init];
	Lake *l1 = [[Lake alloc] init];
	Ocean *o0 = [[Ocean alloc] init];
	Ocean *o1 = [[Ocean alloc] init];
	NSLog(@"Pool");
	[p0 someClassStuff:p1];
	[p0 someClassStuff:l0];
	[p0 someClassStuff:o0];
	
	NSLog(@"Lake");
	[l0 someClassStuff:p0];
	[l0 someClassStuff:l1];
	[l0 someClassStuff:o0];
	
	NSLog(@"Ocean");
	[o0 someClassStuff:p0];
	[o0 someClassStuff:l0];
	[o0 someClassStuff:o1];
}

+(void)classAsKey{
	//NSMutableDictionary<Class,NSString *> *dict = [NSMutableDictionary dictionary];
	//dict[House.class] = @"The House";
}


+(void)replaceStrat2{
	Hijack();
}

+(void)tryHacked{
	House *h = [[House alloc] init];
	h.stuffedInt = 5;
	NSLog(@"stuffedInt: %d",h.stuffedInt);
	h.stuffedInt = 7;
	NSLog(@"stuffedInt: %d",h.stuffedInt);
}


+(void)timeZoneStuff{
	[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	NSTimeZone *plain = [NSTimeZone defaultTimeZone];
	NSTimeZone *local = [NSTimeZone localTimeZone];
	NSLog(@"%d",local.isDaylightSavingTime?1:0);
	NSLog(@"%@",plain);
	NSLog(@"%@",local);
	[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
	NSLog(@"%@",plain);
	NSLog(@"%@",local);
	NSTimeZone *set = [NSTimeZone timeZoneForSecondsFromGMT:-18000];
	NSLog(@"%@",set);
	NSLog(@"%d",set.isDaylightSavingTime?1:0);
}

+(void)dateTimeZoneStuff {
	NSDate *date1 = NSDate.date;
	NSLog(@"%@",date1);
	NSLog(@"secs since 1970 %f",date1.timeIntervalSince1970);
	NSLog(@"dst offset: %f",NSTimeZone.defaultTimeZone.daylightSavingTimeOffset);
	NSLog(@"seconds off gmt: %ld",NSTimeZone.defaultTimeZone.secondsFromGMT);
	
	SHDatetime *dt = [date1 toSHDatetime];
	SHDatetime *dt2 = [date1 toSHDatetimeUTC];
	
	[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	
	NSLog(@"");
	NSLog(@"%@",date1);
	NSLog(@"secs since 1970 %f",date1.timeIntervalSince1970);
	NSLog(@"dst offset: %f",NSTimeZone.defaultTimeZone.daylightSavingTimeOffset);
	NSLog(@"seconds off gmt: %ld",NSTimeZone.defaultTimeZone.secondsFromGMT);
	
	
	
	NSLog(@"");
	NSDate *date2 = NSDate.date;
	NSLog(@"%@",date2);
	NSLog(@"secs since 1970 %f",date1.timeIntervalSince1970);
	NSLog(@"dst offset: %f",NSTimeZone.defaultTimeZone.daylightSavingTimeOffset);
	NSLog(@"seconds off gmt: %ld",NSTimeZone.defaultTimeZone.secondsFromGMT);
	
	

}

+(void)dateTimeStuff{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.year = 1988;
	components.month = 2;
	components.day = 29;
	components.hour = 23;
	components.minute = 59;
	components.second = 59;
	[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *base = [NSCalendar.currentCalendar dateFromComponents:components];
	NSDate *nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitYear value:1 toDate:base options:0];
	NSLog(@"Add 1 Year: %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitYear value:4 toDate:base options:0];
	NSLog(@"Add 4 years: %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitSecond value:1 toDate:base options:0];
	NSLog(@"Add 1 sec: %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitSecond value:1 toDate:base options:NSCalendarWrapComponents];
	NSLog(@"Add 1 Sec(Wrap): %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitSecond value:1 toDate:base options:NSCalendarMatchStrictly];
	NSLog(@"Add 1 Sec(Strict): %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitSecond value:1 toDate:base options:NSCalendarSearchBackwards];
	NSLog(@"Add 1 Sec(SearchBackwards): %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitSecond value:1 toDate:base options:NSCalendarMatchNextTime];
	NSLog(@"Add 1 Sec(NextTime): %@",nsAns);
	
	components.year = 1989;
	components.month = 1;
	components.day = 31;
	components.hour = 4;
	components.minute = 30;
	components.second = 0;
	base = [NSCalendar.currentCalendar dateFromComponents:components];
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:base options:0];
	NSLog(@"Add 1 month: %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:base options:NSCalendarWrapComponents];
	NSLog(@"Add 1 month(wrap): %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:base options:NSCalendarMatchStrictly];
	NSLog(@"Add 1 month(strict): %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:base options:NSCalendarMatchNextTime];
	NSLog(@"Add 1 month(next): %@",nsAns);
	
	nsAns = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:base options:NSCalendarMatchLast];
	NSLog(@"Add 1 month(last): %@",nsAns);
}

+(void)runC_Exp{
	
	arrayExps();
}

+(void)getWeekDayIndexes{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setValue:1776 forComponent:NSCalendarUnitYear];
	[components setValue:7 forComponent:NSCalendarUnitMonth];
	[components setValue:4 forComponent:NSCalendarUnitDay];
	components.calendar = NSCalendar.currentCalendar;
	NSDate *d0 = [components date];
	//NSInteger w = [components weekdayOrdinal];
	//NSLog(@"%@",d0);
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	components = [[NSDateComponents alloc] init];
	[components setValue:1900 forComponent:NSCalendarUnitYear];
	[components setValue:1 forComponent:NSCalendarUnitMonth];
	[components setValue:1 forComponent:NSCalendarUnitDay];
	components.calendar = NSCalendar.currentCalendar;
	d0 = [components date];
	//NSInteger w = [components weekdayOrdinal];
	NSLog(@"%f",d0.timeIntervalSince1970);
}


+(void)memSizeStuff{
	RefO* r = [RefO new];
	r.sm = (int16_t)0xffff;
	r.i16 = (int16_t)0xffff;
	r.i162 = (int16_t)0xffff;
	r.mobj = [NSObject new];
//	r.mobj2 = [NSObject new];
//	r.mobj3 = [NSObject new];
//	r.mobj4 = [NSObject new];
//	r.mobj5 = [NSObject new];
	NSLog(@"malloc size: %lu",malloc_size((__bridge const void*)r));
	NSLog(@"size: %lu",class_getInstanceSize(r.class));
	NSObject* obj = [NSObject new];
	NSData *data = [NSData dataWithBytes:(__bridge const void*)r length:malloc_size((__bridge const void*)r)];
	NSLog(@"Object contains %@", data);
	
	
	WeakHolder* wh = [WeakHolder new];
	
	NSLog(@"weakHolder size: %lu",class_getInstanceSize(wh.class));
	
	NSLog(@"obj size: %lu",class_getInstanceSize(obj.class));
	
}


+(void)memSetErase{
	RefO* r = [RefO new];
	r.i16 = 32;
	r.mobj = [NSObject new];
	NSObject* __weak w = r.mobj;
	(void)w;
//	@autoreleasepool {
	memset((__bridge void*)r,0,malloc_size((__bridge const void*)r));
//	}
	free((__bridge void*)r);
	r.i16 = 71;
}


+(void)endianess{
	int a = 0xabcd;
	NSData *data = [NSData dataWithBytes:&a length:sizeof(int)];
	NSLog(@"Object contains %@", data);

}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunreachable-code"
+(void)autoreleaseJump{
	NSObject* __weak obj = nil;
	@autoreleasepool {
	NSObject* realObj = [NSObject new];;
	obj = realObj;
	NSLog(@"Hey this is me obj %@",obj);
	goto mlabel;
	NSLog(@"Never prints1");
	
	}
	NSLog(@"Never prints2");
	mlabel:;
	NSLog(@"Does print");
	NSLog(@"obj: %@",obj);
	NSLog(@"Next print");
}
#pragma GCC diagnostic pop


+(void)passThruARP{
	NSObject* strob = [NSObject new];
	NSObject* __weak wob = strob;
	@autoreleasepool {
	NSLog(@"The strong: %@",strob);
	}
	strob = nil;
	NSLog(@"The weak: %@",wob);
}

+(FromCFunc*)carveOutObj{
	FromCFunc* obj = [[FromCFunc alloc] init];
	return obj;
}



+(void)clsFromCFunc{
	FromCFunc* funky = [FromCFunc extraNew];
	FromCFunc* notAsfunky = [FromCFunc new];
	FromCFunc* loseDatFunk = [FromCFunc newExtraRelease];
	FromCFunc* otherFunk = [FromCFunc otherNew];
	FromCFunc* maybeFunky = [self carveOutObj];
	FromCFunc* __weak weakFunky = funky;
	FromCFunc* __weak weakNotAsFunky = notAsfunky;
	FromCFunc* __weak weakLostFunk = loseDatFunk;
	FromCFunc* __weak weakOther = otherFunk;
	FromCFunc* __weak weakMaybe = maybeFunky;
	NSLog(@"%@",weakFunky);
	NSLog(@"%@",weakNotAsFunky);
	NSLog(@"%@",weakLostFunk);
	NSLog(@"%@",weakOther);
	NSLog(@"%@",weakMaybe);
	funky = nil;
	notAsfunky = nil;
	loseDatFunk = nil;
	weakOther = nil;
	weakMaybe = nil;
	void* cf = (__bridge void*)weakFunky;
	CFRelease(cf);
	//CFRelease(cf);
	NSLog(@"%@",weakFunky);
	NSLog(@"%@",weakNotAsFunky);
	NSLog(@"%@",weakLostFunk);
	NSLog(@"%@",weakOther);
	NSLog(@"%@",weakMaybe);
}


+(void)lostMems{
	
	__weak House* wh = nil;
	@autoreleasepool {
	House *h = [House new];
	wh = h;
	stupidStruct *ss = malloc(sizeof(stupidStruct));
	ss->firstItem = 18;
	ss->secondItem = 77;
	ss->thirdItem = 76;
	ss->tstPtr = (__bridge_retained void*)h;
	}
}

+(void)ptrExp{
	NSObject *obj = [NSObject new];
	uintptr_t addr = (uintptr_t)obj;
	uintptr_t addr2 = (uintptr_t)&obj;
	uintptr_t indir = (uintptr_t)(*(void **)addr2);
	char * value = *(char **)addr2;
	void* ptr = (void*)addr;
	(void)ptr;(void)value;(void)indir;
	NSLog(@"0x%016lx",addr);
	addr++;
}


+(void)forceNill{
	Retainer *r = [Retainer new];
	__weak NSObject* wob = nil;
	r.obj = [NSObject new];
	@autoreleasepool {
	wob = r.obj;
	}
	
	[TestHelpers setPrivateVar:r ivarName:@"_obj" newVal:nil];
}


+(void)testChildInsertSave{
	SHCoreData *dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
	options.storeType = NSInMemoryStoreType;
	options.appBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
	}];
	NSManagedObjectContext *context = [dc newBackgroundContext];
	[context performBlockAndWait:^{
	SHDaily *d = (SHDaily*)[NSManagedObjectContext newEntityUnattached:SHDaily.entity];
	SHReminder *r = (SHReminder*)[NSManagedObjectContext newEntityUnattached:SHReminder.entity];
	r.daysBeforeDue = 70;
	d.customUserOrder = 700;
	//[d addDaily_remindObject:r];
	[context insertObject:d];
	NSError *err = nil;
	[context save:&err];
	NSLog(@"Save");
	}];
	
	NSManagedObjectContext *context2 = [dc newBackgroundContext];
	[context2 performBlockAndWait:^{
	NSFetchRequest *request = SHDaily.fetchRequest;
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"customUserOrder" ascending:YES] ];
	NSError *error = nil;
	NSArray *results = [context2 executeFetchRequest:request error:&error];
	SHDaily *d = (SHDaily*)results[0];
	NSLog(@"Count is %lu",d.daily_remind.count);
	
	}];
}


+(void)testOrderednessCoreData{
	SHCoreData *dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
	options.storeType = NSSQLiteStoreType;
	options.appBundle = [NSBundle bundleForClass:NSClassFromString(@"SHBundleKey")];
	}];
	NSManagedObjectContext *context = [dc newBackgroundContext];
	[context performBlockAndWait:^{
	SHDaily *d = (SHDaily*)[context newEntity:SHDaily.entity];
	SHReminder *r = (SHReminder*)[context newEntity:SHReminder.entity];
	r.daysBeforeDue = 70;
	d.customUserOrder = 700;
	[d addDaily_remindObject:r];
	SHReminder *r2 = (SHReminder*)[context newEntity:SHReminder.entity];
	r.daysBeforeDue = 71;
	[d addDaily_remindObject:r2];
	SHReminder *r3 = (SHReminder*)[context newEntity:SHReminder.entity];
	r.daysBeforeDue = 72;
	[d addDaily_remindObject:r3];
	SHReminder *r4 = (SHReminder*)[context newEntity:SHReminder.entity];
	r.daysBeforeDue = 73;
	[d addDaily_remindObject:r4];
	NSError *err = nil;
	[context save:&err];
	NSLog(@"Save");
	}];

	NSManagedObjectContext *context2 = [dc newBackgroundContext];
	[context2 performBlockAndWait:^{
	NSFetchRequest *request = SHDaily.fetchRequest;
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"customUserOrder" ascending:YES] ];
	NSError *error = nil;
	NSArray *results = [context2 executeFetchRequest:request error:&error];
	SHDaily *d = (SHDaily*)results[0];
	NSOrderedSet *set = d.daily_remind;
	SHReminder *r = set[0];
	(void)r;
//	[set enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
//		NSLog(@"Loop");
//	}];
	NSLog(@"Count is %lu",d.daily_remind.count);
	
	
	}];
}


+(void)dispatchQueueExp{
	CircleMaybe *cm = [[CircleMaybe alloc] init];
	__weak CircleMaybe *weakCircle = cm;
	[cm dropSelfInQ];
	cm = nil;
	NSLog(@"of main");
	[NSThread sleepForTimeInterval:6];
	NSLog(@"Should be done");
	NSLog(@"Circle? %@",weakCircle);
	
	CircleMaybe *cm2 = [[CircleMaybe alloc] init];
	weakCircle = cm2;
	cm2.foo = [NSObject new];
	NSLog(@"The two guy");
	cm2 = nil;
	NSLog(@"Circle? %@",weakCircle);
	
	CircleMaybe *cm3 = [[CircleMaybe alloc] init];
	weakCircle = cm3;
	[cm3 addBlock];
	cm3 = nil;
	NSLog(@"Strike three!");
	NSLog(@"Circle? %@",weakCircle);
}

+(void)atomicExp{
	for(int i = 1; i <= 25;i++){
	CircleMaybe *cm = [[CircleMaybe alloc] init];
	//[cm nonatomicEx];
	[cm threado];
	NSLog(@"Loop: %d",i);
	}
	NSLog(@"All over");
	
}


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-unsafe-retained-assign"
+(void)privateInst{
	CircleMaybe *q1 = [CircleMaybe new];
	CircleMaybe *q2 = [CircleMaybe new];
	
	[q1 setHouse];
	[q1 checkHouse];
	[q2 checkHouse];
	NSLog(@"Weak shit!");
	q2.mediocre = [House new];
	NSLog(@"Mediocre: %@",q2.mediocre);
	
	[q1 trackStat];
	[q2 trackStat];
}
#pragma GCC diagnostic pop


+(void)ivarList{
	uint32_t outCount = 0;
	Ivar *iv = class_copyIvarList(SimpleDTO.class,&outCount);
	for(uint32_t i = 0; i < outCount; i++){
	const char *varname = ivar_getName(iv[i]);
	NSLog(@"%s",varname);
	}
}

+(void)reflectionCopy{
	SimpleDTO *sdto = [SimpleDTO new];
	sdto.boopStr = @"sploot";
	sdto.dootNum = 17;
	sdto.wrapNum = @77;
	SimpleDTO *sdto2 = [sdto narrowCopy];
	sdto2.boopStr = @"wort";
	//SimpleDTO *copy = object_copy(SimpleDTO.class,sizeof(SimpleDTO))
}


+(void)subStrC{
	const char* str = "atoyota";
	NSString *nsStr = [NSString stringWithUTF8String:&str[1]];
	NSLog(@"%@",nsStr);
}


+(void)KVOStuff{
	SimpleDTO *sdto = [SimpleDTO new];

	//responds = [sdto respondsToSelector:NSSelectorFromString(@"watched")];
	//[sdto sayRealSlimShady];
	Watcher *w = [Watcher new];
	//[sdto addObserver:w forKeyPath:@"watched" options:NSKeyValueObservingOptionNew context:nil];
	[sdto addObserver:w forKeyPath:@"instaWatched" options:NSKeyValueObservingOptionNew context:nil];
	[sdto setValue:@65 forKey:@"watched"];
	//sdto.watched = @34;
	sdto->instaWatched = @63;
	NSLog(@"%@",sdto.watched);
	[sdto setValue:@91 forKey:@"_watched"];
	NSLog(@"%@",sdto.watched);
	NSObject *obj = [NSObject new];
	//obj.everywhere = 6;
	
}


+(void)queuePossibleDeadlock{
	CircleMaybe *cm = [[CircleMaybe alloc] init2];
	NSLog(@"Now we get the num: %lu",cm.bar);
}

+(void)tryingTheKVOverride{
	KVObject *o = [KVObject new];
	o.rock = 92;
}


+(void)testEntityAccessNoSave{
	SHCoreData *dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
	options.storeType = NSInMemoryStoreType;
	options.appBundle = [NSBundle bundleForClass:NSClassFromString(@"SHBundleKey")];
	}];
	
	NSManagedObjectContext *context = [dc newBackgroundContext];
	
	[context performBlockAndWait:^{
	SHDaily *d =	(SHDaily*)[context newEntity:SHDaily.entity];
	d.dailyName = @"hola";
	}];
	__block NSManagedObjectID *objectID = nil;
	[context performBlockAndWait:^{
	NSFetchRequest *request =	SHDaily.fetchRequest;
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dailyName" ascending:YES]];
	NSArray *results = [context executeFetchRequest:request error:nil];
	SHDaily *d = (SHDaily*)results[0];
	objectID = d.objectID;
	NSLog(@"%@",d.dailyName);
	}];
	
	[context performBlockAndWait:^{
	SHDaily *d = [context existingObjectWithID:objectID error:nil];
	NSLog(@"%@",d.dailyName);
	}];
	
	NSManagedObjectContext *context2 = [dc newBackgroundContext];
	[context2 performBlockAndWait:^{
	SHDaily *d = [context2 existingObjectWithID:objectID error:nil];
	NSLog(@"%@",d.dailyName);
	}];
}


+(void)cfArrayStuff{
	int32_t arraySize = 10;
	CFMutableArrayRef array = CFArrayCreateMutable(kCFAllocatorDefault, arraySize, NULL);
	NSMutableArray *arr = (__bridge_transfer NSMutableArray*)array;
//	CFMutableArrayRef cfarr = (__bridge CFMutableArrayRef)arr;
	stupidStruct ss;
	ss.firstItem = 5;
	ss.secondItem = 19;
	ss.thirdItem = 21;
	//CFArrayAppendValue(array, &ss);
	[arr addObject:(__bridge id)&ss];
	//void* ssid = (__bridge void *)(arr[0]);
	stupidStruct *ss2 = (stupidStruct *)CFArrayGetValueAtIndex(array,0);//(__bridge stupidStruct *)(arr[0]);
	NSLog(@"%d",ss2->thirdItem);
	
}

void checkSize(id object){
	NSLog(@"%lu",sizeof(object));
}

union u_double {
	double dbl;
	int64_t data;
};

+(void)primitiveType{
	int a = 5;
	NSObject *oscar = [NSObject new];
	typeof(a) b = 7;
	char* c = "abb";
	double pi = 3.14;
	union u_double d;
	d.dbl = 3.14;
	int64_t b2 = d.data;
	double c2 = d.dbl;
	NSNumber *num = [NSNumber numberWithDouble:b2];
	double c3 = num.doubleValue;
	//NSLog(@"%f",pi2);
	char* code = @encode(typeof(c));
	checkSize(oscar);
	NSLog(@"hi");
}


+(void)postInsertion{
	SHCoreData *dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
	//options.storeType = NSInMemoryStoreType;
	options.appBundle = [NSBundle bundleForClass:NSClassFromString(@"SHBundleKey")];
	}];
	
	NSManagedObjectContext *context = [dc newBackgroundContext];
	[context performBlockAndWait:^{
	SHDaily *d =	(SHDaily*)[context newEntity:SHDaily.entity];
	d.dailyName = @"hola";
	//[context save:nil];
	}];
	__block NSManagedObjectID *objectID = nil;
	[context performBlockAndWait:^{
	NSFetchRequest *request =	SHDaily.fetchRequest;
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dailyName" ascending:YES]];
	NSArray *results = [context executeFetchRequest:request error:nil];
	SHDaily *d = (SHDaily*)results[0];
	objectID = d.objectID;
	NSLog(@"%@",d.dailyName);
	for (SHDaily *d_ in results) {
		NSLog(@"%d",d_.inserted);
	}
	}];
	
}


+(void)switchSemantics{
	int num = 0;
	BOOL avoid = YES;
	switch(num) {
	case 0:
		if(avoid) {
		NSLog(@"0: avoiding");
		break;
		}
		NSLog(@"0: failed to avoid");
		break;
	case 1:
		{
		if(avoid) {
			NSLog(@"1: avoiding");
			break;
		}
		}
		NSLog(@"1: failed to avoid");
		break;
	}
}


+(void)testPropCopy{
	ChildMan *c1 = [[ChildMan alloc] init];
	c1.whamjar = 198;
	c1.whoitZoot = 2046;
	c1.contrlNum = 129;
	ChildMan *c2 = [[ChildMan alloc] init];
	[c2 narrowCopyFrom:c1];
}


+(void)blockLocalObjRef {
	ChildMan *c1 = [[ChildMan alloc] init];
	c1.myBlock = ^{
		NSLog(@"Other stuff");
		//[c1 printShit];
	};
	__weak ChildMan *c2 = c1;
	c1 = nil;
	NSLog(@"is it null? %@",c2);
}


+(void)printPropsOfClass:(House *)h{
	uint32_t outCount = 0;
	Ivar* ivars = class_copyIvarList(House.class, &outCount);
	for(uint32_t i = 0; i < outCount;i++){
		const char * cName = ivar_getName(*ivars);
		NSString *name = [NSString stringWithUTF8String:cName];
		//void *v = NULL;
		//object_getInstanceVariable(img, cName, &v);
		if(!*ivars) continue;
		id v = object_getIvar(h,*ivars);
		NSLog(@"%@ : %@",name,v);
		ivars++;
		 
	}
}


+(void)loopThruIvars {
	House *h = [House new];
	h.count = 7;
	[self printPropsOfClass:h];
}


+(void)classCompare {
	House *h0 = [House new];
	GenericThing *thing = [[GenericThing alloc] init];
	ChildMan *cm = [[ChildMan alloc] init];
	ParentMan *pm = [[ParentMan alloc] init];
	NSLog(@"House is house? %@", h0.class == House.class ? @"yes" : @"no");
	NSLog(@"House is thing? %@", h0.class == thing.class ? @"yes" : @"no");
	NSLog(@"childman is parentman? %@", cm.class == pm.class ? @"yes" : @"no");
	NSLog(@"childman is parentman? %@", cm.class == ParentMan.class ? @"yes" : @"no");
	NSLog(@"childman super is parentman? %@", cm.superclass == ParentMan.class ? @"yes" : @"no");
	NSLog(@"class childman super is parentman? %@", ChildMan.superclass == ParentMan.class ? @"yes" : @"no");
	NSLog(@"class childman super super is object? %@", ChildMan.superclass.superclass == NSObject.class ? @"yes" : @"no");
	NSLog(@"class childman super super super is nil? %@", ChildMan.superclass.superclass.superclass == nil ? @"yes" : @"no");
}

@end
