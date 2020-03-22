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


NS_ASSUME_NONNULL_BEGIN

typedef void (^activationActionType)(BOOL,SHContextObjectIDWrapper *);

@interface SHDailyActivator : NSObject
@property (strong,nonatomic) SHContextObjectIDWrapper *objectID;
@property (copy,nonatomic) activationActionType activationAction;
@property (strong,nonatomic) NSObject<SHDateProviderProtocol> *dateProvider;
-(instancetype)initWithObjectId:(SHContextObjectIDWrapper *)objectID;
-(void)activate;
@end

NS_ASSUME_NONNULL_END
