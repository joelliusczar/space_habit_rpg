//
//  SHInvocationsBucketSet.m
//  SHControls
//
//  Created by Joel Pridgen on 4/8/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHInvocationsBucketSet.h"
@import SHCommon;

@implementation SHInvocationsBucketSet

-(SHInvocationDict *)classListTrait {
	if(nil == _classListTrait) {
		_classListTrait = [NSMutableDictionary dictionary];
	}
	return _classListTrait;
}


-(SHInvocationDict *)classList {
	if(nil == _classList) {
		_classList = [NSMutableDictionary dictionary];
	}
	return _classList;
}


-(SHInvocationDict *)trait {
	if(nil == _trait) {
		_trait = [NSMutableDictionary dictionary];
	}
	return _trait;
}


-(SHInvocationDict *)single {
	if(nil == _single) {
		_single = [NSMutableDictionary dictionary];
	}
	return _single;
}


-(SHInvocationDict*)selectOperationSet {
	if(self.classListTrait.count > 0) {
		return self.classListTrait;
	}
	if(self.classList.count > 0) {
		return self.classList;
	}
	if(self.trait > 0) {
		return self.trait;
	}
	return self.single;
}


-(void)mergeIn:(SHInvocationsBucketSet*)bucketSet {
	[self.classListTrait mergeDictionary: bucketSet.classListTrait];
	[self.classList mergeDictionary: bucketSet.classList];
	[self.trait mergeDictionary: bucketSet.trait];
	[self.single mergeDictionary: bucketSet.single];
}

@end
