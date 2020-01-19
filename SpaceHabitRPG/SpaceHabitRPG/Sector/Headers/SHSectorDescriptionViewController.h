//
//	SHSectorDescriptionViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/20/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceViewController.h"
#import "SHStoryDumpViewController.h"
@import UIKit;
@import SHModels;


@class SHSectorChoiceViewController;

@interface SHSectorDescriptionViewController : SHStoryDumpViewController
@property (nonatomic,weak) SHSector *sector;
@property (copy,nonatomic) void (^onSectorSelectionAction)(SHSector*);
-(instancetype)initWithOnSelectionAction:(void (^)(SHSector*))onSectorSelectionAction;
@end
