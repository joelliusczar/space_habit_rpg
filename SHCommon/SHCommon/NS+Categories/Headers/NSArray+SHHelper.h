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
-(NSMutableArray*)arrayWithItemsAsDicts;

-(NSMutableArray*)arrayWithItemsAsDictsWithTransformer:
	(shDictEntrytransformer)transformer
	withSet:(NSMutableSet*)cycleTracker;
	
-(NSUInteger)findPlaceFor:(ItemType)object whereFirstFits:(BOOL (^)(ItemType,ItemType))bestFitBlock;
-(NSUInteger)findPlaceFor:(ItemType)object whereFirstFitsFP:(BOOL (*)(ItemType,ItemType))bestFitFP;

-(NSMutableArray*)mapItemsTo:(id (^)(id,NSUInteger))mapper;
-(NSMutableArray*)mapItemsTo_f:(id _Nonnull (*_Nonnull)(id _Nonnull, NSUInteger))mapper;
-(ItemType)silentGet:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
