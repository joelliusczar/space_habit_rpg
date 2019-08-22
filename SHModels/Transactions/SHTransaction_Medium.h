//
//	SHSHTransaction_Medium.h
//	SHModels
//
//	Created by Joel Pridgen on 4/22/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHTransaction_Medium : NSObject
@property (readonly,strong,nonatomic) NSManagedObjectContext *context;
@property (readonly,strong,nonatomic) NSString *entityType;
-(instancetype)initWithContext:(NSManagedObjectContext *)context
	andEntityType:(NSString*)entityType;
-(void)addCreateTransaction:(NSDictionary *)info;
-(void)addBatchDeleteTransaction:(NSString*)info;

@end

NS_ASSUME_NONNULL_END
