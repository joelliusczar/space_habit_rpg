//
//  TestGlobals.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef TestGlobals_h
#define TestGlobals_h

#define ASSERT_IS_TEST() XCTAssertEqual([SingletonCluster getSharedInstance].EnviromentNum,ENV_UTEST)
#define DELETE_ALL() [[SingletonCluster getSharedInstance].dataController deleteAllRecords]

#endif /* TestGlobals_h */
