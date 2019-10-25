//
//  SHButton.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewProtocol.h"
@import UIKit;
@import SHCommon;

@interface SHButton : UIButton<P_SHView>
@property (strong,nonatomic) id<SHInterceptorProtocol> interceptor;
@end
