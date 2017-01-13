//
//  IntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStackController.h"
#import "Settings+CoreDataClass.h"
#import "CentralViewController.h"
#import "ChoiceScreenBase.h"

@interface IntroViewController : UIViewController <ChoiceScreenBase>
-(id)initWithCentralViewController:(CentralViewController *)central;
-(void)setToSkipStory:(BOOL)skipStory;
-(CoreDataStackController *)getTheDataController;
@end

