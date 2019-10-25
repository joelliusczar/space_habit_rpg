//
//	SHSingletonCluster+Data.h
//	SHData
//
//	Created by Joel Pridgen on 2/27/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SHCoreData.h"
@import SHCommon;

#define SHDataGlobal [SHSingletonCluster getSharedInstance].dataController

@interface SHSingletonCluster (Data)
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@property (copy,nonatomic) void (^constructorBlock)(SHCoreDataOptions*);
@end
