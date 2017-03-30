//
//  P_SingletonCluster.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CoreData.h"
#import "P_ResourceUtility.h"

@protocol P_SingletonCluster <NSObject>
+(instancetype)getSharedInstance;
-(NSObject<P_CoreData> *)getDataController;
-(NSObject<P_ResourceUtility> *)getResourceUtility;
@end
