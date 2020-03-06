//
//  SHStoryDumpViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHControls;
@import SHModels;

@interface SHStoryDumpViewController : SHViewController
@property (weak,nonatomic) IBOutlet UITextView *synopsisView;
@property (weak,nonatomic) IBOutlet UIButton *doneBtn;
@property (weak,nonatomic) IBOutlet UITextView *headlineLbl;
@property (strong,nonatomic) NSObject<SHStoryItemProtocol> * storyItemObject;
@property (nonatomic) UIColor* backgroundColor;
@property (copy,nonatomic) void (^responseBlock)(SHStoryDumpViewController *);
-(instancetype)initWithStoryItemObject:(NSObject<SHStoryItemProtocol> *)storyItem;
-(instancetype)initWithDefaultNib;
@end
