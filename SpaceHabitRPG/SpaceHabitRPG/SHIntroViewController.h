//
//  SHIntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHConfig.h>
#import <SHModels/SHSector_Medium.h>
#import <SHModels/SHSectorDTO.h>
#import "SHCentralViewController.h"



@interface SHIntroViewController : UIViewController
-(instancetype)initWithCentralViewController:(SHCentralViewController *)central;
@end

