//
//  TestDummy.h
//  TestCommon
//
//  Created by Joel Pridgen on 3/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestDummy : NSObject
@property (strong,nonatomic) TestDummy* td;
-(void)methodWithARP;
-(void)justSomething;
+(instancetype)extraNew;
@end

NS_ASSUME_NONNULL_END
