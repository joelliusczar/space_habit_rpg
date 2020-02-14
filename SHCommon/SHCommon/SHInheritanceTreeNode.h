//
//  SHInheritanceTreeNode.h
//  SHControls
//
//  Created by Joel Pridgen on 2/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHInheritanceTreeNode<NodeStorage> : NSObject
@property (strong, nonatomic) Class key;
@property (strong, nonatomic) NodeStorage storedObject;
@property (readonly, nonatomic) NSMutableArray<SHInheritanceTreeNode<NodeStorage>*> *children;
-(instancetype)initWithKey:(Class)key withStoredObject:(NodeStorage)storedObject;
@end

NS_ASSUME_NONNULL_END


