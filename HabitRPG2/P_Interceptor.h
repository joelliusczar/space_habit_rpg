//
//  P_Interceptor.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^wrapReturnVoid)(void);
typedef BOOL (^wrapReturnBool)(void);

@protocol P_Interceptor <NSObject>
-(void)callVoidWrapped:(wrapReturnVoid)callMe withInfo:(id)info;
-(BOOL)callBoolWrapped:(wrapReturnBool)callMe withInfo:(id)info;
@end
