//
//  SHEnumerator.h
//  SHCommon
//
//  Created by Joel Pridgen on 1/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHEnumerator<elementType> : NSObject
@property (strong, nonatomic) NSArray<elementType> *backend;
@property (readonly, nonatomic, nullable) elementType current;
-(elementType)moveNext;
@end

NS_ASSUME_NONNULL_END
