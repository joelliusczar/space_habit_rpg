//
//  SHInvocationsBucketSet.h
//  SHControls
//
//  Created by Joel Pridgen on 4/8/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

@import Foundation;

typedef NSMutableDictionary<NSString *,NSInvocation*> SHInvocationDict;

NS_ASSUME_NONNULL_BEGIN

@interface SHInvocationsBucketSet : NSObject
@property (strong, nonatomic) SHInvocationDict *classListTrait;
@property (strong, nonatomic) SHInvocationDict *classList;
@property (strong, nonatomic) SHInvocationDict *trait;
@property (strong, nonatomic) SHInvocationDict *single;
-(SHInvocationDict*)selectOperationSet;
-(void)mergeIn:(SHInvocationsBucketSet*)bucketSet;
@end

NS_ASSUME_NONNULL_END
