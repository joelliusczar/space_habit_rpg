//
//  SHSHViewProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHInterceptorProtocol.h>

@protocol P_SHView <NSObject>
@property (strong,nonatomic) id<SHInterceptorProtocol> interceptor;
@end
