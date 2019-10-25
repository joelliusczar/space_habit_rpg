//
//  SHResourceUtilityProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@protocol SHResourceUtilityProtocol <NSObject>
-(nonnull NSDictionary *)getPListDict:(nonnull NSString*)fileName withBundle:(nonnull NSBundle *)bundle;
-(nonnull NSArray *)getPListArray:(nonnull NSString*)fileName withBundle:(nonnull NSBundle *)bundle;
@end
