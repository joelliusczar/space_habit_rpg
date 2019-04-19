//
//  IntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHSettings+CoreDataClass.h>
#import <SHModels/SHSector_Medium.h>
#import <SHModels/SHSectorDTO.h>
#import "CentralViewController.h"



@interface IntroViewController : UIViewController
-(instancetype)initWithCentralViewController:(CentralViewController *)central;
@end

