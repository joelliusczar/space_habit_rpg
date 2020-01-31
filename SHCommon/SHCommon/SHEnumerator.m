//
//  SHEnumerator.m
//  SHCommon
//
//  Created by Joel Pridgen on 1/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHEnumerator.h"

@interface SHEnumerator ()
@property (assign, nonatomic) NSUInteger idx;
@end

@implementation SHEnumerator

@synthesize current = _current;

-(id)current {
	return _current;
}


-(instancetype)init {
	if(self = [super init]){
		_idx = 0;
	}
	return self;
}


-(id)moveNext {
	if(self.idx >= self.backend.count) {
		_current = nil;
		return _current;
	}
	_current = self.backend[self.idx];
	self.idx++;
	return _current;
}


@end
