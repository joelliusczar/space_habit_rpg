//
//	SHSingletonCluster+Data.m
//	SHData
//
//	Created by Joel Pridgen on 2/27/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SingletonCluster+Data.h"
#import "SHCoreData.h"
@import SHCommon;

@implementation SHSingletonCluster (Data)


-(dispatch_queue_t)dbQueue {
	static dispatch_queue_t dbQueue;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dbQueue = dispatch_queue_create("com.SpaceHabit.DbQueue",
			DISPATCH_QUEUE_SERIAL);
	});
	return dbQueue;
}


-(dispatch_queue_t)constructorBlockQueue {
	static dispatch_queue_t constructorBlockQueue;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		constructorBlockQueue = dispatch_queue_create(
			"com.SpaceHabit.constructorBlockQueue",
			DISPATCH_QUEUE_SERIAL);
	});
	return constructorBlockQueue;
}


-(void (^)(SHCoreDataOptions*))constructorBlock{
	__block void (^optionsBlock)(SHCoreDataOptions*);
	dispatch_sync(self.constructorBlockQueue,^{
		optionsBlock = [self.bag getWithKey:@"constructorBlock" OrCreateFromBlock:^id(){
			return ^(SHCoreDataOptions *options){
				options.dbFileName = DEFAULT_DB_NAME;
			};
		}];
	});
	return optionsBlock;
}

-(void)setConstructorBlock:(void (^)(SHCoreDataOptions *))constructorBlock{
	dispatch_async(self.constructorBlockQueue, ^{
		self.bag[@"constructorBlock"] = constructorBlock;
	});
}

-(NSObject<P_CoreData> *)dataController{
	__block NSObject<P_CoreData> *dataController = nil;
	dispatch_sync(self.dbQueue, ^{
		dataController = [self.bag getWithKey:@"dc" OrCreateFromBlock:^id(id obj){
				SHSingletonCluster* sc = (SHSingletonCluster*)obj;
				return [SHCoreData newWithOptionsBlock:sc.constructorBlock];
		} withObj:self];
	});
	return dataController;
}


-(void)setDataController:(NSObject<P_CoreData> *)dataController{
	dispatch_async(self.dbQueue, ^{
		self.bag[@"dc"] = dataController;
	});
}

@end
