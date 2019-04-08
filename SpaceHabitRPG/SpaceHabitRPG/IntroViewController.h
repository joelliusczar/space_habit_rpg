//
//  IntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/Settings+CoreDataClass.h>
#import <SHModels/Zone_Medium.h>
#import <SHModels/SHZoneDTO.h>
#import "CentralViewController.h"



@interface IntroViewController : UIViewController
-(instancetype)initWithCentralViewController:(CentralViewController *)central;
@end

