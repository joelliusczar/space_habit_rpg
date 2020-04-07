//
//  SHInheritanceSortingTreeNode.m
//  SHControls
//
//  Created by Joel Pridgen on 2/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import "SHInheritanceTree.h"

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


-(instancetype)initWithCompareFunction:(BOOL (^)(id a, id b))isAChildOfB
	withExactMatchFunction:(BOOL (^)(id a, id b))isExactMatch
	withRoot:(SHInheritanceTreeNode *)root
{
	if(self = [super init]) {
		_isAChildOfB = isAChildOfB;
		_isExactMatch = isExactMatch;
		_root = root;
	}
	return self;
}


static SHInheritanceTreeNode*  _findMatch(id key, SHInheritanceTreeNode *root,
	SHInheritanceTreeNode *lastBestMatch,
	BOOL (^isAChildOfB)(id a, id b))
{
	SHInheritanceTreeNode *bestMatch = lastBestMatch;
	if(isAChildOfB(key, root.key)) {
		bestMatch = root;
		for (SHInheritanceTreeNode *child in root.children) {
			bestMatch = _findMatch(key, child, bestMatch, isAChildOfB);
		}
	}
	return bestMatch;
}


-(id)findMatch:(id)key {
	if(nil == self.root) return nil;
	SHInheritanceTreeNode *match = _findMatch(key, self.root, nil, self.isAChildOfB);
	if(match) {
		return match.storedObject;
	}
	return nil;
}


static SHInheritanceTreeNode* _findExactMatch(id key, SHInheritanceTreeNode *root,
 BOOL (^isExactMatch)(id a, id b))
{
	if(isExactMatch(key, root.key)) return root;
	for (SHInheritanceTreeNode *child in root.children) {
		id match = _findExactMatch(key, child, isExactMatch);
		if(match) return match;
	}
	return nil;
}

-(id)findExactMatch:(id)key {
	if(nil == self.root) return nil;
	return _findExactMatch(key, self.root, self.isExactMatch).storedObject;
}


-(SHInheritanceTreeNode *)addObjectAndGetNearestParent:(id)object withKey:(id)key {
	if(nil == self.root) {
		self.root = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
		return nil;
	}
	SHInheritanceTreeNode *match = _findMatch(key, self.root, nil, self.isAChildOfB);
	if(match) {
		SHInheritanceTreeNode *node = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
		[match.children addObject:node];
	}
	return match;
}


static void _runAction(void (^action)(id key, id stored), id key,
	SHInheritanceTreeNode *root, BOOL (^isAChildOfB)(id a, id b))
{
	if(nil == root) return;
	if(isAChildOfB(key, root.key)){
		action(root.key, root.storedObject);
		for (SHInheritanceTreeNode *child in root.children) {
    	_runAction(action, key, child, isAChildOfB);
		}
	}
	
}


-(void)runAction:(void (^)(id key, id stored))action
	matchingKey:(id)key
{
	_runAction(action, key, self.root, self.isAChildOfB);
}


-(NSString*)description {
	return self.root.description;
}


@end


