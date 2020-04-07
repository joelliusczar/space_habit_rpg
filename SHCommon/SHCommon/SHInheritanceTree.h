//
//  SHInheritanceSortingTreeNode.h
//  SHControls
//
//  Created by Joel Pridgen on 2/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHInheritanceTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHInheritanceTree<NodeKey, NodeStorage> : NSObject
@property (copy, nonatomic) BOOL (^isAChildOfB)(NodeKey a, NodeKey b);
@property (copy, nonatomic) BOOL (^isExactMatch)(NodeKey a, NodeKey b);
-(instancetype)initWithCompareFunction:(BOOL (^)(NodeKey a, NodeKey b))isAChildOfB
	withExactMatchFunction:(BOOL (^)(NodeKey a, NodeKey b))isExactMatch;
-(instancetype)initWithCompareFunction:(BOOL (^)(NodeKey a, NodeKey b))isAChildOfB
	withExactMatchFunction:(BOOL (^)(NodeKey a, NodeKey b))isExactMatch
	withRoot:(SHInheritanceTreeNode<NodeKey, NodeStorage> *)root;

/*
	findMatch: this function is used to find nearest parent to a given child.
*/
-(nullable NodeStorage)findMatch:(NodeKey)key;
-(nullable NodeStorage)findExactMatch:(NodeKey)key;
-(nullable SHInheritanceTreeNode<NodeKey, NodeStorage> *)addObjectAndGetNearestParent:(NodeStorage)object
	withKey:(NodeKey)key;
-(void)runAction:(void (^)(NodeKey key, NodeStorage stored))action
	matchingKey:(NodeKey)key;
@end

NS_ASSUME_NONNULL_END

