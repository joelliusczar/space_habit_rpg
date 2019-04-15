//
//  CircleMaybe.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "House.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleMaybe : NSObject
-(instancetype)init2;
@property (nonatomic) NSObject *foo;
@property (assign,nonatomic) NSInteger bar;
@property (assign,nonatomic) NSInteger nonic;
@property (weak,nonatomic) House *mediocre;
@property (strong,nonatomic,nullable) NSArray<House*>* corruptyo;
-(void)makeNoise;
-(void)dropSelfInQ;
-(void)addBlock;
-(void)nonatomicEx;
-(void)setHouse;
-(void)checkHouse;
-(void)trackStat;
-(void)threado;
@end

NS_ASSUME_NONNULL_END
