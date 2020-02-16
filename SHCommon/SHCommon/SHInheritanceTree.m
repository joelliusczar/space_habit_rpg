//
//  SHInheritanceSortingTreeNode.m
//  SHControls
//
//  Created by Joel Pridgen on 2/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import "SHInheritanceTree.h"
#import "SHInheritanceTreeNode.h"

@interface SHInheritanceTree ()
@property (strong, nonatomic) SHInheritanceTreeNode *root;
@end

@implementation SHInheritanceTree


-(instancetype)initWithCompareFunction:(BOOL (^)(id a, id b))isAChildOfB {
	if(self = [super init]) {
		_isAChildOfB = isAChildOfB;
	}
	return self;
}


static id _findMatch(id key, SHInheritanceTreeNode *root, id lastBestMatch,
	BOOL (^isAChildOfB)(id a, id b))
{
	id bestMatch = lastBestMatch;
	if(isAChildOfB(key, root.key)) {
		bestMatch = root.storedObject;
		for (SHInheritanceTreeNode *child in root.children) {
			bestMatch = _findMatch(key, child, bestMatch, isAChildOfB);
		}
	}
	return bestMatch;
}


-(id)findMatch:(id)key {
	if(nil == self.root) return nil;
	return _findMatch(key, self.root, nil, self.isAChildOfB);
}

static BOOL _addObjectHelper(id object, id key, SHInheritanceTreeNode *root,
	BOOL (^isAChildOfB)(id a, id b))
{
	if(nil == root) return NO;
	if(isAChildOfB(key, root.key)) {
		for (SHInheritanceTreeNode *child in root.children) {
    	if(_addObjectHelper(object, key, child, isAChildOfB)) return YES;
		}
		SHInheritanceTreeNode *node = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
		[root.children addObject: node];
		return YES;
	}
	return NO;
}

-(void)addObject:(id)object withKey:(id)key {
	if(nil == self.root) {
		self.root = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
		return;
	}
	_addObjectHelper(object, key, self.root, self.isAChildOfB);
}


@end


