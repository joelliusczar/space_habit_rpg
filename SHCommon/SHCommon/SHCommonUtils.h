//
//	SHCommonUtils.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/21/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#ifndef SHCommonUtils_h
#define SHCommonUtils_h

@import Foundation;
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

//taken from https://stackoverflow.com/a/25662295/1866885
#define SH_IS_OBJECT(x) (strchr("@#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_BOOL(x) (strchr("b#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_CHAR(x) (strchr("c#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("C#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_CSTR(x) (strchr("*#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_INT(x) (strchr("s#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("i#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("l#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("q#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_UNSIGNED_INT(x) (strchr("S#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("I#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("L#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("Q#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_FLOAT(x) (strchr("f#", @encode(typeof(x))[0]) != NULL) \
	|| (strchr("d#", @encode(typeof(x))[0]) != NULL)
#define SH_IS_STRUCT(x) (strchr("{#", @encode(typeof(x))[0]) != NULL)


extern uint (*shRandomUInt)(uint);
void shReverse_UINT(NSUInteger * array,NSUInteger len);
CGFloat shGetParentChildHeightOffset(CGRect parentFrame,CGRect childFrame);
BOOL shWaitForSema(dispatch_semaphore_t sema,NSInteger timeoutSecs);
void shCopyInstanceVar(NSObject* from,NSObject* to,NSString *varName);
NSArray<NSString*> *shBuildWeekBasedOnWeekStart(NSUInteger weekStart);
NSString* shWeekDayKeyToFull(NSString * dayKey);
#endif

