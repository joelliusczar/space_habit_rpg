//
//  StoryDumpView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_StoryItem.h"
#import "SHButton.h"

@interface StoryDumpView : UIViewController
@property (weak,nonatomic) IBOutlet UITextView *synopsisView;
@property (weak,nonatomic) IBOutlet SHButton *doneBtn;
@property (weak,nonatomic) IBOutlet UILabel *headlineLbl;
@property (strong,nonatomic) NSObject<P_StoryItem> *storyItem;
-(instancetype)initWithStoryItem:(NSObject<P_StoryItem> *)storyItem;
@end
