//
//  FromCFunc.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/8/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface FromCFunc : NSObject
+(instancetype)extraNew;
+(instancetype)newExtraRelease;
+(instancetype)otherNew;
@property (strong,nonatomic) NSString* nombre;
-(void)doATrick;
@end

//typedef struct FromCFunc CFFromCFunc;

NS_ASSUME_NONNULL_END
