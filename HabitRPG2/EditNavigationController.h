//
//  EditNewDailyController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingSaver.h"

@interface EditNavigationController : UIViewController
-(void)setupTaskEditor:(id<EditingSaver>)editView;
-(id)initCustom;
@end
