//
//  SHTextField.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_Interceptor.h"
#import "P_SHView.h"

@interface SHTextField : UITextField
@property (strong,nonatomic) id<P_Interceptor> interceptor;
@end
