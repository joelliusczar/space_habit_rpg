//
//  SHInheritanceTreeNode.h
//  SHControls
//
//  Created by Joel Pridgen on 2/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHInheritanceTreeNode<NodeKey, NodeStorage> : NSObject
@property (strong, nonatomic) NodeKey key;
@property (strong, nonatomic) NodeStorage storedObject;
@property (strong, nonatomic) NSMutableArray<SHInheritanceTreeNode<NodeKey,NodeStorage>*> *children;
-(instancetype)initWithKey:(NodeKey)key withStoredObject:(NodeStorage)storedObject;
@end

NS_ASSUME_NONNULL_END


