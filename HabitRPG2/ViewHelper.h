//
//  ViewHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewHelper : NSObject
+(void)pushViewToFront:(UIViewController *)child OfParent:(UIViewController *)parent;
+(void)popViewFromFront:(UIViewController *)child OfParent:(UIViewController *)parent;
@end
