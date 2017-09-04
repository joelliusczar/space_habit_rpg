//
//  NSObject+Helper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHEventInfo.h"
@import UIKit;

@interface NSObject (Helper)
-(void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
                  context:(void *)context;
-(UIView *)loadXib:(NSString *)nibName;
@end
