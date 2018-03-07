//
//  TestGlobals.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef TestGlobals_h
#define TestGlobals_h

#define ASSERT_IS_TEST() if([SingletonCluster getSharedInstance].EnviromentNum!=ENV_UTEST) \
[NSException raise:@"invalid environment" format:@"This is not test"]


#endif /* TestGlobals_h */
