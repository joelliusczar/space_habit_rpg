//
//  SHInheritanceSortingTreeNode.h
//  SHControls
//
//  Created by Joel Pridgen on 2/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHInheritanceTree<NodeStorage> : NSObject
-(NodeStorage)findMatch:(Class)key;
-(void)addObject:(NodeStorage)object withKey:(Class)key;
@end

NS_ASSUME_NONNULL_END

