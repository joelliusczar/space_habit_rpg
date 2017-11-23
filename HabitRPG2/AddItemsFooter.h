//
//  RemindersFooter.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_AddItemsFooterDelegate.h"
#import "SHView.h"
#import "SHButton.h"

IB_DESIGNABLE
@interface AddItemsFooter : SHView
@property (weak,nonatomic) IBOutlet SHButton *addItemBtn;
@property (weak,nonatomic) IBOutlet id<P_AddItemsFooterDelegate> delegate;
@end
