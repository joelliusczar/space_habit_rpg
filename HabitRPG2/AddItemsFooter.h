//
//  RemindersFooter.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_AddItemsFooterDelegate.h"
#import "ControlController.h"

@interface AddItemsFooter : ControlController
@property (weak,nonatomic) id<P_AddItemsFooterDelegate> delegate;
@end
