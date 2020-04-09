//
//	NSArray+Helper.h
//	SHCommon
//
//	Created by Joel Pridgen on 4/18/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
#import "SHCollectionUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ItemType> (SHHelper)

typedef _Nonnull ItemType (*SH_mapper_CFn)(_Nonnull ItemType, NSUInteger);
typedef _Nonnull ItemType (^SH_mapperBlock)(_Nonnull ItemType, NSUInteger);

-(NSMutableArray*)arrayWithItemsAsDicts;

-(NSMutableArray*)arrayWithItemsAsDictsWithTransformer:
	(shDictEntrytransformer)transformer
	withSet:(NSMutableSet*)cycleTracker;
	
-(NSUInteger)findPlaceFor:(ItemType)object whereFirstFits:(BOOL (^)(ItemType,ItemType))bestFitBlock;
-(NSUInteger)findPlaceFor:(ItemType)object whereFirstFitsFP:(BOOL (*)(ItemType,ItemType))bestFitFP;

-(NSMutableArray*)mapItemsTo:(SH_mapperBlock)mapper;
-(NSMutableArray*)mapItemsTo_f:(SH_mapper_CFn)mapper;
-(nullable ItemType)silentGet:(NSUInteger)index;
-(NSMutableArray<ItemType> *)SH_subtractArray:(NSArray<ItemType> *)arr;
@end

NS_ASSUME_NONNULL_END
