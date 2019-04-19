//
//  SHCommonUtils.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#ifndef SHCommonUtils_h
#define SHCommonUtils_h

#import <Foundation/Foundation.h>
@import CoreGraphics;

/* 
Hash combining method from 
http://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
*/
#define NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define NSUINT_Rotate(val,howmuch) \
 ( ((NSUInteger)val) << howmuch | ((NSUInteger)val) >> (NSUINT_BIT - howmuch) )

/*I have considered making shRandomUInt
into a macro and then redefining it for tests but macros are expanded
at compile time and since different project are compiled at different times,
I could not depend on it, so instead I am using a function pointer stored in a
public variable that I can swap out at run time
*/
extern uint (*shRandomUInt)(uint);
void shReverse_UINT(NSUInteger * array,NSUInteger len);
CGFloat shGetParentChildHeightOffset(CGRect parentFrame,CGRect childFrame);
BOOL shWaitForSema(dispatch_semaphore_t sema,NSInteger timeoutSecs);
void shCopyInstanceVar(NSObject* from,NSObject* to,NSString *varName);
#endif

