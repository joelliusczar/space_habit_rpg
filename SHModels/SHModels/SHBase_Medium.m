//
//  SHBase_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 8/31/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHBase_Medium.h"

@implementation SHBase_Medium

-(instancetype)initWithContext:(NSManagedObjectContext*)context{
	if(self = [super init]){
		_context = context;
	}
	return self;
}

@end
