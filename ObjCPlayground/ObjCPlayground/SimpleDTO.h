//
//	SimpleDTO.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleDTO : NSObject{
  @public
  NSNumber *instaWatched;
}
@property NSString *boopStr;
@property NSInteger dootNum;
@property NSNumber *wrapNum;
@property (nonatomic) NSNumber *watched;
-(void)sayRealSlimShady;
@end

NS_ASSUME_NONNULL_END
