//
//  WeakHolder.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 2/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakHolder : NSObject
@property (weak,nonatomic) NSObject* item1;
@property (weak,nonatomic) NSObject* item2;
@property (weak,nonatomic) NSObject* item3;
@property (weak,nonatomic) NSObject* item4;
@property (weak,nonatomic) NSObject* item5;
@property (weak,nonatomic) NSObject* item6;
//@property (weak,nonatomic) NSObject* item7;
@end

NS_ASSUME_NONNULL_END
