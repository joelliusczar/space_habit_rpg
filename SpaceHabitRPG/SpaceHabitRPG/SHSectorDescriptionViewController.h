//
//	SHSectorDescriptionViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/20/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceViewController.h"
#import "SHStoryDumpView.h"
@import UIKit;
@import SHModels;
@import SHData;


@class SHSectorChoiceViewController;

@interface SHSectorDescriptionViewController : SHStoryDumpView
@property (nonatomic,weak) SHSector *sector;
@property (copy,nonatomic) void (^onSectorSelectionAction)(SHSector*);
-(instancetype)initWithViewController:(UIViewController *)prevScreen
	withOnSelectionAction:(void (^)(SHSector*))onSectorSelectionAction;
@end
