//
//	SHTransaction_Medium.m
//	SHModels
//
//	Created by Joel Pridgen on 4/22/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHTransaction_Medium.h"
@import SHGlobal;
@import SHCommon;
@import SHData;


@implementation SHTransaction_Medium


-(instancetype)initWithContext:(NSManagedObjectContext *)context
	andEntityType:(NSString*)entityType
{
	if(self = [super init]){
		_context = context;
		_entityType = entityType;
	}
	return self;
}


-(void)addCreateTransaction:(NSDictionary *)info{
	NSManagedObjectContext* context = self.context;
	[context performBlock:^{
		SHTransaction *t =(SHTransaction *)[context newEntity: SHTransaction.entity];
		t.entityType = self.entityType;
		t.timestamp = [NSDate date];
		t.transType = SH_TRANSACTION_TYPE_CREATE;
		t.misc = [info dictToString];
		NSError *error = nil;
		[context save:&error];
	}];
}


-(void)addBatchDeleteTransaction:(NSString*)info{
	NSManagedObjectContext* context = self.context;
	[context performBlock:^{
		SHTransaction *t =(SHTransaction *)[context newEntity:SHTransaction.entity];
		t.entityType = self.entityType;
		t.timestamp = [NSDate date];
		t.transType = SH_TRANSACTION_TYPE_BATCH_DELETE;
		t.misc = info;
		NSError *error = nil;
		[context save:&error];
	}];
}

@end
