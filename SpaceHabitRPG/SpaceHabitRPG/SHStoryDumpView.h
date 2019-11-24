//
//  SHStoryDumpView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHControls;
@import SHData;
@import SHModels;

@interface SHStoryDumpView : UIViewController
@property (weak,nonatomic) IBOutlet UITextView *synopsisView;
@property (weak,nonatomic) IBOutlet SHButton *doneBtn;
@property (weak,nonatomic) IBOutlet UILabel *headlineLbl;
@property (strong,nonatomic) NSObject<SHStoryItemProtocol> * storyItemObject;
@property (nonatomic) UIColor* backgroundColor;
@property (copy,nonatomic) void (^responseBlock)(SHStoryDumpView *);
-(instancetype)initWithStoryItemObject:(NSObject<SHStoryItemProtocol> *)storyItem;
-(instancetype)initWithDefaultNib;
@end
