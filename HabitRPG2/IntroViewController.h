//
//  IntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings+CoreDataClass.h"
#import "CentralViewControllerP.h"

@interface IntroViewController : UIViewController
-(id)initWithCentralViewController:(UIViewController<CentralViewControllerP> *)central;
@end

