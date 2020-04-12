//
//	FrequentCase.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/4/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"
#import "SHCoreData+CleanUp.h"
#import "SHTestResourceUtil.h"
@import SHModels;

@import CoreData;

@interface FrequentCase ()
@property (weak,nonatomic) NSObject* weakObj;
@property (strong,nonatomic) NSObject* strongObj;
@property (strong,nonatomic) NSBundle *testBundle;
@end

@implementation FrequentCase


SHCoreData* getDataControllerSingleton(){
	static SHCoreData *dc = nil;
	static dispatch_once_t onceToken = 0;
	dispatch_once(&onceToken,^{
		dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
			options.storeType = NSInMemoryStoreType;
			options.appBundle = [NSBundle bundleForClass:NSClassFromString(@"SHBundleKey")];
		}];
	});
	return dc;
}

-(void)setUp{
	[super setUp];
	self.testBundle = [NSBundle bundleForClass:NSClassFromString(@"SHBundleKey")];
	SHResourceUtility *baseResourceUtil = [[SHResourceUtility alloc] initWithBundle:self.testBundle];
	self.resourceUtil = [[SHTestResourceUtil alloc] initWithResourceUtil:baseResourceUtil];
	
	self.sectorInfoDict = [[SHSectorInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	self.monsterInfoDict = [[SHMonsterInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	SHSector.sectorInfo = self.sectorInfoDict;
	SHMonster.monsterInfo = self.monsterInfoDict;
	//I think we want to ensure that it uses the bundle from SHModels rather
	//the bundle for TestUI or TestCommon
	self.dc = getDataControllerSingleton();
	SHConfig.dayStartTime = 0;
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

-(void)resetDb{
	[self.dc resetCoreData];
	
}



-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
context:(NSManagedObjectContext*)context{
	request.predicate = [NSPredicate predicateWithValue:YES];
	
	NSArray<NSManagedObject*>* results = [context getItemsWithRequest:request];
	return results;
}

-(void)tearDown{
//	NSManagedObjectContext *mainThreadContext = SHData.mainThreadContext;
//	SharedGlobal.dataController = nil;
//	void *releasable = (__bridge void*)mainThreadContext;
//	CFRelease(releasable);
	[self resetDb];
	[super tearDown];
}



@end
