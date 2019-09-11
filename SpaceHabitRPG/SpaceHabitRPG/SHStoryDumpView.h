//
//  SHStoryDumpView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHStoryItemProtocol.h>
#import <SHControls/SHButton.h>
#import <SHData/SHData.h>

@interface SHStoryDumpView : UIViewController
@property (weak,nonatomic) IBOutlet UITextView *synopsisView;
@property (weak,nonatomic) IBOutlet SHButton *doneBtn;
@property (weak,nonatomic) IBOutlet UILabel *headlineLbl;
@property (strong,nonatomic) SHObjectIDWrapper *storyItemObjectID;
@property (nonatomic) UIColor* backgroundColor;
@property (copy,nonatomic) void (^responseBlock)(SHStoryDumpView *);
-(instancetype)initWithStoryItemObjectID:(SHObjectIDWrapper *)storyItemObjectID;
@end
