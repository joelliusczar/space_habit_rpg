//
//  EditNewDailyController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/11/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingSaver.h"

@interface EditNavigationController : UIViewController <UINavigationBarDelegate>
@property (nonatomic,strong) NSString *viewTitle;
-(void)setupTaskEditor:(id<EditingSaver>)editView;
-(id)initWithTitle:(NSString *)viewTitle;
@end
