//
//  NSMutableArray+Helper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHGlobal/SHConstants.h>


@interface NSMutableArray<ItemType> (Helper)
-(NSUInteger)findPlaceFor:(id)object whereBestFits:(BOOL (^)(ItemType,ItemType))bestFitBlock;
-(NSUInteger)findPlaceFor:(id)object whereBestFitsFP:(BOOL (*)(ItemType,ItemType))bestFitFP;
@end
