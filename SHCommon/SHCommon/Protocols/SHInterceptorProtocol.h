//
//  SHInterceptorProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHGlobal/SHCommonTypeDefs.h"

@protocol SHInterceptorProtocol <NSObject>
-(void)callVoidWrapped:(shWrapReturnVoid)callMe withInfo:(id)info;
-(BOOL)callBoolWrapped:(shWrapReturnBool)callMe withInfo:(id)info;
@end
