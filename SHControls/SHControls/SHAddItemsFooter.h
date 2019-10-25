//
//  RemindersFooter.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHAddItemsFooterDelegateProtocol.h"
#import "SHView.h"
#import "SHButton.h"
@import UIKit;

IB_DESIGNABLE
@interface SHAddItemsFooter : UIViewController
@property (weak,nonatomic) IBOutlet UIButton *addItemBtn;
@property (weak,nonatomic) IBOutlet id<SHAddItemsFooterDelegateProtocol> delegate;
@end
