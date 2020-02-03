//
//  SHEnumerator.m
//  SHCommon
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHEnumerator.h"

@interface SHEnumerator ()
@property (assign, nonatomic) NSUInteger idx;
@end

@implementation SHEnumerator

-(instancetype)initWithBackend:(NSArray*)backend {
	if(self = [super init]){
		_backend = backend;
		_idx = 0;
	}
	return self;
}


-(id)current {
	if(self.idx >= self.backend.count) {
		return nil;
	}
	return self.backend[self.idx];
}


-(id)moveNext {
	self.idx++;
	return self.current;
}

@end
