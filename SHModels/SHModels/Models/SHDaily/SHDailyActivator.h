//
//  SHDailyActivator.h
//  SHModels
//
//  Created by Joel Pridgen on 8/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDaily.h"
#import "SHConfig.h"
@import Foundation;
@import SHData;


NS_ASSUME_NONNULL_BEGIN

typedef void (^activationActionType)(BOOL,SHObjectIDWrapper *);

@interface SHDailyActivator : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectID;
@property (copy,nonatomic) activationActionType activationAction;
-(instancetype)initWithContext:(NSManagedObjectContext *)context withObjectId:(SHObjectIDWrapper *)objectID;
-(void)activate;
@end

NS_ASSUME_NONNULL_END
