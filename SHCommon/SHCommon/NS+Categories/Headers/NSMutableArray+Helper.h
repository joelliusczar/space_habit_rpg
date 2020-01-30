//
//  NSMutableArray+Helper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;



@interface NSMutableArray<ItemType> (Helper)
-(NSUInteger)findPlaceFor:(id)object whereBestFits:(BOOL (^)(ItemType,ItemType))bestFitBlock;
-(NSUInteger)findPlaceFor:(id)object whereBestFitsFP:(BOOL (*)(ItemType,ItemType))bestFitFP;
-(void)SH_enqueue:(id)obj;
-(id)SH_dequeue;
+(NSMutableArray*)variadicToArray:(id)values, ... NS_REQUIRES_NIL_TERMINATION;
@end
