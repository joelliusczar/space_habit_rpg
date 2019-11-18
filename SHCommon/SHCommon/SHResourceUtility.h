//
//  SHResourceUtility.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "SHResourceUtilityProtocol.h"

@interface SHResourceUtility : NSObject<SHResourceUtilityProtocol>
@property (strong, nonatomic) NSBundle *bundle;
-(instancetype)initWithBundle:(NSBundle*)bundle;
@end
