//
//  ChoiceScreenBase.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStackController.h"

@protocol ChoiceScreenBase <NSObject>
@optional
-(void)setToSkipStory:(BOOL)skipStory;
-(void)jumpToCentralView:(UIViewController *)currentView;
@required
@property (nonatomic,weak,readonly) UIViewController<ChoiceScreenBase> *viewStackBottom;
-(CoreDataStackController *)getTheDataController;
@end
