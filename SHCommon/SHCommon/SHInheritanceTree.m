//
//  SHInheritanceSortingTreeNode.m
//  SHControls
//
//  Created by Joel Pridgen on 2/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import "SHInheritanceTree.h"
#import "NSArray+SHHelper.h"

@interface SHInheritanceTree ()
@property (strong, nonatomic) NSMutableArray<SHInheritanceTreeNode*> *roots;
@end

@implementation SHInheritanceTree


-(NSMutableArray<SHInheritanceTreeNode*>*)roots {
	if(nil == _roots) {
		_roots = [NSMutableArray array];
	}
	return _roots;
}


-(instancetype)initWithCompareFunction:(BOOL (^)(id a, id b))isAChildOfB
	withExactMatchFunction:(BOOL (^)(id a, id b))isExactMatch
{
	if(self = [super init]) {
		_isAChildOfB = isAChildOfB;
		_isExactMatch = isExactMatch;
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
	for (SHInheritanceTreeNode *root in self.roots) {
		SHInheritanceTreeNode *match = _findMatch(key, root, nil, self.isAChildOfB);
		if(match) {
			return match.storedObject;
		}
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
	for (SHInheritanceTreeNode *root in self.roots) {
    SHInheritanceTreeNode *match = _findExactMatch(key, root, self.isExactMatch);
    if(match) {
    	return match.storedObject;
		}
	}
	return nil;
}



-(SHInheritanceTreeNode *)addObjectAndGetNearestParent:(id)object withKey:(id)key {
	SHInheritanceTreeNode *parent = nil;
	NSUInteger length = self.roots.count;
	for(NSUInteger idx = 0; idx < length; idx++) {
		SHInheritanceTreeNode *root = self.roots[idx];
		SHInheritanceTreeNode *match = _findMatch(key, root, nil, self.isAChildOfB);
		if(match) {
			SHInheritanceTreeNode *node = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
			for (SHInheritanceTreeNode *child in match.children) {
    		if(self.isAChildOfB(child.key, key)) {
    			[node.children addObject:child];
				}
			}
			match.children = [match.children SH_subtractArray:node.children];
			[match.children addObject:node];
			return match;
		}
		if(self.isAChildOfB(root.key, key)) {
			if(nil == parent) {
				parent = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
			}
			[parent.children addObject:root];
			[self.roots removeObjectAtIndex:idx];
			length--;
			idx--;
		}
	}
	if(parent) {
		[self.roots addObject:parent];
		return nil;
	}
	SHInheritanceTreeNode *node = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
	[self.roots addObject:node];
	return nil;
}


static void _runAction(void (^action)(SHInheritanceTreeNode *node), id key,
	SHInheritanceTreeNode *root, BOOL (^isAChildOfB)(id a, id b))
{
	if(nil == root) return;
	if(isAChildOfB(key, root.key)){
		action(root);
		for (SHInheritanceTreeNode *child in root.children) {
    	_runAction(action, key, child, isAChildOfB);
		}
	}
	
}


-(void)runAction:(SH_treeIterationAction)action
	matchingKey:(id)key
{
	for (SHInheritanceTreeNode *root in self.roots) {
		_runAction(action, key, root, self.isAChildOfB);
	}
}


-(NSString*)description {
	NSString *formattedChildren = [self.roots componentsJoinedByString:@",\n"];
	NSString *desc = [NSString stringWithFormat:@"[\n\root: [\n\t%@\n\t]\n\t]",
		formattedChildren];
	return desc;
}


@end


