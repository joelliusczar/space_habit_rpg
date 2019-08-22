//
//	RefO.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 2/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefO : NSObject
@property (assign,nonatomic) int16_t sm;
@property (assign,nonatomic) int16_t i16;
@property (strong,nonatomic) NSObject* mobj;
@property (assign,nonatomic) int16_t i162;
@property (strong,nonatomic) NSObject *mobj2;
@property (strong,nonatomic) NSObject *mobj3;
@property (strong,nonatomic) NSObject *mobj4;
@property (strong,nonatomic) NSObject *mobj5;
//@property (strong,nonatomic) NSObject *mobj6;
@end

NS_ASSUME_NONNULL_END
