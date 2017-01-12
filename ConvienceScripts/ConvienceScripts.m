//
//  ConvienceScripts.m
//  ConvienceScripts
//
//  Created by Joel Pridgen on 1/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStackController.h"

@interface ConvienceScripts : XCTestCase
@property (nonatomic,strong) CoreDataStackController *dataController;
@end

@implementation ConvienceScripts

- (void)setUp {
    [super setUp];
    self.dataController = [[CoreDataStackController alloc] init];
}

-(void)testClearDB{
    @try {
        [self.dataController deleteAllRecords];
    } @catch (NSException *exception) {
        NSLog(@"Error when trying to delete everything");
    }
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



@end
