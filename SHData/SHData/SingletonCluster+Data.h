//
//  SingletonCluster+Data.h
//  SHData
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>
#import "P_CoreData.h"

#define SAVE_DATA_ASYNC() [[SingletonCluster getSharedInstance].dataController saveNoWaiting]
#define SHData [SingletonCluster getSharedInstance].dataController

@interface SingletonCluster (Data)
@property (nonatomic) NSString *dbFileName;
@property (nonatomic) NSObject<P_CoreData> *dataController;
@end
