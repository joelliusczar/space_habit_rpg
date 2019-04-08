//
//  CircleMaybe.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleMaybe : NSObject
@property (nonatomic) NSObject *foo;
@property (assign,nonatomic) NSInteger bar;
-(void)makeNoise;
-(void)dropSelfInQ;
-(void)addBlock;
@end

NS_ASSUME_NONNULL_END
