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


static id _findMatch(Class key, SHInheritanceTreeNode *root, id lastBestMatch) {
	id bestMatch = lastBestMatch;
	if([key isSubclassOfClass: root.key]) {
		bestMatch = root.storedObject;
		for (SHInheritanceTreeNode *child in root.children) {
			bestMatch = _findMatch(key, child, bestMatch);
		}
	}
	return bestMatch;
}


-(id)findMatch:(Class)key {
	if(nil == self.root) return nil;
	return _findMatch(key, self.root, nil);
}

static BOOL _addObjectHelper(id object, Class key, SHInheritanceTreeNode *root)
{
	if(nil == root) return NO;
	if([key isSubclassOfClass: root.key]) {
		for (SHInheritanceTreeNode *child in root.children) {
    	if(_addObjectHelper(object, key, child)) return YES;
		}
		SHInheritanceTreeNode *node = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
		[root.children addObject: node];
		return YES;
	}
	return NO;
}

-(void)addObject:(id)object withKey:(Class)key {
	if(nil == self.root) {
		self.root = [[SHInheritanceTreeNode alloc] initWithKey:key withStoredObject:object];
		return;
	}
	_addObjectHelper(object, key, self.root);
}


@end


