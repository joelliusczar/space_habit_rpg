//
//  P_CoreData.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHGlobal/SHConstants.h>
@import CoreData;

typedef NSManagedObjectContext SHContext;

@protocol P_CoreData <NSObject>
@property (strong,nonatomic) SHContext *mainThreadContext;
-(NSManagedObjectContext*)newBackgroundContext;
@end
