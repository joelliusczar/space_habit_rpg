//
//  SHResourceUtilityProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol SHResourceUtilityProtocol <NSObject>
-(NSURL*)getFileUrl:(NSString*)fileName;
-(NSURL*)getURLMutableFile:(NSString*)fileName;
-(NSDictionary *)getPListDict:(NSString*)fileName;
-(NSMutableDictionary*)getPListMutableDict:(NSString*)fileName;
-(NSArray *)getPListArray:(NSString*)fileName;

@end

NS_ASSUME_NONNULL_END
