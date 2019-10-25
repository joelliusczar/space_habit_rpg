//
//  SHTextField.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewProtocol.h"
@import UIKit;
@import SHCommon;

@interface SHTextField : UITextField
@property (strong,nonatomic) id<SHInterceptorProtocol> interceptor;
@end
