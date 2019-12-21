//
//  SHDataProviderProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
@import SHGlobal;
@import CoreData;

typedef NSManagedObjectContext SHContext;

@protocol SHDataProviderProtocol <NSObject>
@property (strong,nonatomic) SHContext *mainThreadContext;
-(NSManagedObjectContext*)newBackgroundContext;
@end
