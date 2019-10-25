//
//	CoreDataTests2.m
//	SHUnitTests
//
//	Created by Joel Pridgen on 2/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHData;
@import SHModels;
#import <SHTestCommon/TestHelpers.h>
@import CoreData;

@interface CoreDataTests2 : XCTestCase

@end

@implementation CoreDataTests2

- (void)setUp {
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
}


NSObject* newObj(){
	NSObject* obj = [[NSObject alloc] init];
	return obj;
}


-(NSObject*)objcNew{
	NSObject* obj = [[NSObject alloc] init];
	return obj;
}


void nullOut(){
	NSObject* obj = [[NSObject alloc] init];
	NSObject* __weak wob = obj;
	NSLog(@"Before null? %@",wob);
	obj = nil;
	NSLog(@"After null? %@",wob);
}

-(void)testWeakFromCFunc{
	NSObject* __weak wob = nil;
	NSObject* sob = [self objcNew];
	wob = sob;
	sob = nil;
}

void nullRef(NSObject* __weak * wob){
	NSObject* obj = [[NSObject alloc] init];
	*wob = obj;
}


-(void)testWeakPassedRef{
	NSObject* __weak outvar = nil;
	nullRef(&outvar);
	
}

@end
