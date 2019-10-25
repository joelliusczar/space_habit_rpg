//
//	NSObject+Helper.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/23/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#if IS_IOS
@import UIKit;
#endif

@interface NSObject (Helper)

-(void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
	context:(void *)context;

-(BOOL)isDictionaryType;
-(id)narrowCopy;
-(void)narrowCopyFrom:(NSObject*)fromObject;


#if IS_IOS
-(UIView *)loadXib:(NSString *)nibName;
#endif

@end
