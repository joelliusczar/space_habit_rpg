//
//	NSOrderedSet+SHHelper.h
//	SHCommon
//
//	Created by Joel Pridgen on 4/18/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
#import "SHCollectionUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSOrderedSet (SHHelper)
-(NSMutableArray*)arrayWithItemsAsDicts;

-(NSMutableArray*)arrayWithItemsAsDictsWithTransformer:
	(shDictEntrytransformer)transformer
	withSet:(NSMutableSet*)cycleTracker;

@end

NS_ASSUME_NONNULL_END
