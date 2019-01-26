//
//  MonsterTransaction_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/P_CoreData.h>
#import "Monster+CoreDataClass.h"
#import "MonsterTransaction+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MonsterTransaction_Medium : NSObject
+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController;
-(void)addCreateTransaction:(Monster *)m;
@end

NS_ASSUME_NONNULL_END
