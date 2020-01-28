//
//  SHDebugDefines.h
//  
//
//  Created by Joel Pridgen on 9/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#ifndef SHDebugDefines_h
#define SHDebugDefines_h

#define shDebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define shTmpDbgPrint(s, ...) NSLog(s, ##__VA_ARGS__)

#endif /* SHDebugDefines_h */
