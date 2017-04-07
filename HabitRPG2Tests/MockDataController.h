//
//  MockDataController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CoreData.h"

@interface MockDataController : NSObject<P_CoreData>
    @property (nonatomic,strong) NSMutableDictionary<NSString *,NSMutableArray *> *mockContext;
    @property (nonatomic,assign) int32_t testCaseIndex;
@end
