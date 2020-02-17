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


-(instancetype)initWithCompareFunction:(BOOL (^)(id a, id b))isAChildOfB
	withExactMatchFunction:(BOOL (^)(id a, id b))isExactMatch
{
	if(self = [super init]) {
		_isAChildOfB = isAChildOfB;
		_isExactMatch = isExactMatch;
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


static id _findExactMatch(id key, SHInheritanceTreeNode *root,
 BOOL (^isExactMatch)(id a, id b))
{
	if(isExactMatch(key, root.key)) return root.storedObject;
	for (SHInheritanceTreeNode *child in root.children) {
		id match = _findExactMatch(key, child, isExactMatch);
		if(match) return match;
	}
	return nil;
}

-(id)findExactMatch:(id)key {
	if(nil == self.root) return nil;
	return _findExactMatch(key, self.root, self.isExactMatch);
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


-(NSString*)description {
	return self.root.description;
}


@end


