//
//	Indexable.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@interface Indexable : NSObject

-(id)objectAtIndexedSubscript:(NSUInteger)idx;

-(id)objectForKeyedSubscript:(id)key;

@end
