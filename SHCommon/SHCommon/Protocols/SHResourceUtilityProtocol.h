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
-(NSURL*)getFileUrl:(NSString*)fileKey;
-(NSURL*)getURLMutableFile:(NSString*)fileKey;
-(NSDictionary *)getPListDict:(NSString*)fileKey;
-(NSMutableDictionary*)getPListMutableDict:(NSString*)fileKey;
-(NSArray *)getPListArray:(NSString*)fileKey;
-(NSMutableArray*)getPListMutableArray:(NSString*)fileKey;
-(void)erase:(NSString*)fileKey;
@end

NS_ASSUME_NONNULL_END
