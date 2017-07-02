//
//  RemindersFooter.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_AddItemsFooterDelegate.h"

@interface AddItemsFooter : UIView
@property (weak,nonatomic) IBOutlet AddItemsFooter *mainView;
@property (weak,nonatomic) id<P_AddItemsFooterDelegate> delegate;
@end
