//
//  SHProbWeight.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@interface SHProbWeight : NSObject
-(void)add:(NSString *)key with:(int32_t)freq;
-(NSString *)weightedRandomKey;
@end
