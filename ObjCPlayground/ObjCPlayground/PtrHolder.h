//
//	PtrHolder.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/3/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PtrHolder : NSObject
@property (assign,nonatomic) uintptr_t item1;
@property (assign,nonatomic) uintptr_t item2;
@property (assign,nonatomic) uintptr_t item3;
@property (assign,nonatomic) uintptr_t item4;
@property (assign,nonatomic) uintptr_t item5;
@property (assign,nonatomic) uintptr_t item6;
@end

NS_ASSUME_NONNULL_END
