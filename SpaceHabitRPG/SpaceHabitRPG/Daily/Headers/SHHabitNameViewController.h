//
//  SHHabitNameViewController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 3/6/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <SHControls/SHControls.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHHabitNameViewController : SHViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UITextField *namebox;
@property (copy, nonatomic) void (^onNext)(NSString *name);
@end

NS_ASSUME_NONNULL_END
