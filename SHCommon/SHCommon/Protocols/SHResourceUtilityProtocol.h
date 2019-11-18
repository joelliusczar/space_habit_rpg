//
//  SHResourceUtilityProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@protocol SHResourceUtilityProtocol <NSObject>
-(nonnull NSURL*)getFileUrl:(nonnull NSString*)fileName;
-(nonnull NSDictionary *)getPListDict:(nonnull NSString*)fileName;
-(nonnull NSMutableDictionary *)getPListMutableDict:(nonnull NSString*)fileName;
-(nonnull NSArray *)getPListArray:(nonnull NSString*)fileName;

@end
