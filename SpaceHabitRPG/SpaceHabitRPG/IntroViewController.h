//
//  IntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/Settings+CoreDataClass.h>
#import "P_CentralViewController.h"

@interface IntroViewController : UIViewController
-(id)initWithCentralViewController:(UIViewController<P_CentralViewController> *)central;
@end

