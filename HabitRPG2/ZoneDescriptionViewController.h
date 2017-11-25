//
//  ZoneDescriptionViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Zone+CoreDataClass.h"
#import "ZoneChoiceViewController.h"
#import "StoryDumpView.h"

@class ZoneChoiceViewController;

@interface ZoneDescriptionViewController : StoryDumpView
-(instancetype)init:(ZoneChoiceViewController *)prevScreen;
-(void)setDisplayItems:(Zone *)model;
@end
