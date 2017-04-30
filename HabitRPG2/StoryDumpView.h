//
//  StoryDumpView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_StoryItem.h"

@interface StoryDumpView : UIViewController
-(instancetype)initWithStoryItem:(NSObject<P_StoryItem> *)storyItem;
@end
