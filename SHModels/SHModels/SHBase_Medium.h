//
//  SHBase_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 8/31/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/NSManagedObjectContext+Helper.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHBase_Medium : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
-(instancetype)initWithContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
