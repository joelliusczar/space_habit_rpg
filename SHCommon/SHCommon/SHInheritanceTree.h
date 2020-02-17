//
//  SHInheritanceSortingTreeNode.h
//  SHControls
//
//  Created by Joel Pridgen on 2/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHInheritanceTree<NodeKey, NodeStorage> : NSObject
@property (copy, nonatomic) BOOL (^isAChildOfB)(NodeKey a, NodeKey b);
@property (copy, nonatomic) BOOL (^isExactMatch)(NodeKey a, NodeKey b);
-(NodeStorage)findMatch:(NodeKey)key;
-(NodeStorage)findExactMatch:(NodeKey)key;
-(void)addObject:(NodeStorage)object withKey:(NodeKey)key;
-(instancetype)initWithCompareFunction:(BOOL (^)(NodeKey a, NodeKey b))isAChildOfB
	withExactMatchFunction:(BOOL (^)(NodeKey a, NodeKey b))isExactMatch;
@end

NS_ASSUME_NONNULL_END

