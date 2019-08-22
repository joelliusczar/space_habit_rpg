//
//	CircleMaybe.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 4/7/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "CircleMaybe.h"

@interface CircleMaybe ()
@property (nonatomic) dispatch_queue_t q;
@property (strong,nonatomic) NSObject *secretFoo;
@property (assign,nonatomic) NSInteger boot;
@property (copy,nonatomic) void (^myBlock)(void);
@end

static NSInteger stato;

@implementation CircleMaybe{
	House *h;
	House *h2;
}

@synthesize mediocre = _mediocre;
-(House*)mediocre{
	return _mediocre;
}

-(void)setMediocre:(House *)mediocre{
	_mediocre = mediocre;
}
//-(House*)mediocre{
//	//return h2;
//	return _mediocre;
//}
//
//-(void)setMediocre:(House *)mediocre{
//	//h2 = mediocre;
//	_mediocre = mediocre;
//}

-(NSObject*)foo{
	__block id result = nil;
	dispatch_sync(self.q,^{
		result = [self secretFoo];
	});
	return result;
}

-(void)setFoo:(NSObject *)foo{
	dispatch_async(self.q,^{
		self.secretFoo = foo;
	});
}

@synthesize bar = _bar;
-(NSInteger)bar{
	__block NSInteger result = 0;
	dispatch_sync(self.q,^{
		result = self->_bar;
	});
	return result;
}


-(void)setBar:(NSInteger)bar{
	dispatch_async(self.q,^{
		self->_bar = bar;
	});
}

-(instancetype)init{
	if(self = [super init]){
		_q = dispatch_queue_create("My_que", DISPATCH_QUEUE_SERIAL);
		_boot = 17;
		_corruptyo = @[[House new],[House new],[House new],[House new]];
	}
	return self;
}


-(instancetype)init2{
	if(self = [super init]){
		_q = dispatch_queue_create("My_que", DISPATCH_QUEUE_SERIAL);
		dispatch_queue_t cq = dispatch_queue_create("conc",DISPATCH_QUEUE_CONCURRENT);
		dispatch_sync(_q,^{
			NSLog(@"In concurrent");
			
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				self.bar = 83;
				//[NSThread sleepForTimeInterval:5];
			}];
		});
	}
	return self;
}


-(void)makeNoise{
	NSLog(@"Hello from CircleMaybe");
}


-(void)dropSelfInQ{
	dispatch_async(self.q,^{
		[NSThread sleepForTimeInterval:5];
		[self makeNoise];
		NSLog(@"%lu",self.boot);
		
	});
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-retain-cycles"
-(void)addBlock{
	self.myBlock = ^{
		[self makeNoise];
	};
}
#pragma	GCC diagnostic pop


-(void)nonatomicEx{;
	dispatch_queue_t cq = dispatch_queue_create("conc",DISPATCH_QUEUE_CONCURRENT);
	dispatch_queue_t cq2 = dispatch_queue_create("conc2",DISPATCH_QUEUE_CONCURRENT);
	//for(int i = 1; i <= 1000; i++){
		dispatch_async(cq, ^{
			@autoreleasepool {
				House *result = self.corruptyo[0];
				[result returnsNothing];
				NSLog(@"ANything? --- %@",result);
			}
		});
		dispatch_async(cq2,^{
			@autoreleasepool {
				NSLog(@"2: ");
				self.corruptyo = nil;
				
				NSLog(@"that motherfucker! ---- ");
			}
		});

	//}

}

-(void)actionPlace1{
	House *result = self.corruptyo[0];
	NSLog(@"ANything? --- %@",result);
}


-(void)actionPlace2{
	NSLog(@"2: ");
	self.corruptyo = nil;

	NSLog(@"that motherfucker! ---- ");
}


-(void)threado{
	NSThread *t1 = [[NSThread alloc] initWithBlock:^{
		@autoreleasepool {
			House *result = self.corruptyo[0];
			[result returnsNothing];
			NSLog(@"ANything? --- %@",result);
		}
	}];
	
	NSThread *t2 = [[NSThread alloc] initWithBlock:^{
		@autoreleasepool {
			NSLog(@"2: ");
			self.corruptyo = nil;
		}

		NSLog(@"that motherfucker! ---- ");
	}];
	[t1 start];
	[t2 start];
}


-(void)setHouse{
	h = [House new];
	NSLog(@"%@",h);
}


-(void)checkHouse{
	NSLog(@"And den: %@",h);
}

-(void)dealloc{
	NSLog(@"Deallocating this cunt!");
}


-(void)trackStat{
	stato += 5;
	NSLog(@"%lu",stato);
}

@end
