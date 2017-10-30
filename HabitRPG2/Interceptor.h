//
//  Interceptor.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_Interceptor.h"

@interface Interceptor : NSObject<P_Interceptor>
+(void)callVoidWrapped:(wrapReturnVoid)callMe withInfo:(id)info;
@end
