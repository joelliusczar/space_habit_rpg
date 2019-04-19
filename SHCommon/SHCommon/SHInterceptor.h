//
//  SHInterceptor.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHInterceptorProtocol.h"

@interface SHInterceptor : NSObject<SHInterceptorProtocol>
+(void)callVoidWrapped:(shWrapReturnVoid)callMe withInfo:(id)info;
@end
