//
//	SHViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHCommon/SHInterceptorProtocol.h>
#import "SHNestedControlProtocol.h"

@interface SHViewController : UIViewController<SHNestedControlProtocol>
@property (strong,nonatomic) id<SHInterceptorProtocol> interceptor;
@end
