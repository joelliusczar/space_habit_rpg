//
//  BaseViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNavigationController.h"
#import "CoreDataStackController.h"
#import "Daily+CoreDataClass.h"

@interface BaseViewController : UIViewController
@property (strong,nonatomic) CoreDataStackController *dataController;
@property (nonatomic,strong) EditNavigationController *editController;
-(void)doActionForCompletedDaily:(Daily *)daily;
-(void)undoActionForCompletedDaily:(Daily *)daily;
-(void)setToSkipStory:(BOOL)skipStory;
-(void)dismissIntro;
@end
