//
//  rateSetterViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rateSetterDelegate.h"

@interface rateSetterViewController : UIViewController
@property (weak,nonatomic) id<rateSetterDelegate> delegate;
@end
