//
//	SHSectorDescriptionViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/20/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHSector.h>
#import <SHModels/SHSectorDTO.h>
#import "SHSectorChoiceViewController.h"
#import "SHStoryDumpView.h"
#import <SHData/SHData.h>
#import <SHModels/SHStoryItemObjectID.h>



@class SHSectorChoiceViewController;

@interface SHSectorDescriptionViewController : SHStoryDumpView
@property (nonatomic,weak) SHStoryItemObjectID *storyObjectID;
@property (copy,nonatomic) void (^onSectorSelectionAction)(SHStoryItemObjectID*);
-(instancetype)initWithSectorChoiceViewController:(SHSectorChoiceViewController *)prevScreen
	withOnSelectionAction:(void (^)(SHStoryItemObjectID*))onSectorSelectionAction
	withStoryObjectID:(SHStoryItemObjectID*)storyObjectID;
-(instancetype)initWithSectorChoiceViewController:(SHSectorChoiceViewController *)prevScreen
	withOnSelectionAction:(void (^)(SHStoryItemObjectID*))onSectorSelectionAction;
@end
