//
//  Interceptor.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^wrapReturnVoid)();
typedef int32_t (^wrapReturnInt32)();


@interface Interceptor : NSObject
+(void)callVoidWrapped:(wrapReturnVoid)callMe withInfo:(id)info;
+(int32_t)callInt32Wrapped:(wrapReturnInt32)callMe withInfo:(id)info;
@end
