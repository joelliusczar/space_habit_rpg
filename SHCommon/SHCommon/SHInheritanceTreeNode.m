//
//  SHInheritanceTreeNode.m
//  SHControls
//
//  Created by Joel Pridgen on 2/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHInheritanceTreeNode.h"

@implementation SHInheritanceTreeNode

@synthesize children = _children;
-(NSMutableArray*)children {
	if(nil == _children) {
		_children = [NSMutableArray array];
	}
	return _children;
}


-(instancetype)initWithKey:(Class)key withStoredObject:(id)storedObject {
	if(self == [super init]) {
		_key = key;
		_storedObject = storedObject;
	}
	return self;
}

@end


