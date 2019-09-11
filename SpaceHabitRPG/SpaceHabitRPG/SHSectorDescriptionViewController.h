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

@class SHSectorChoiceViewController;

@interface SHSectorDescriptionViewController : SHStoryDumpView
-(instancetype)init:(SHSectorChoiceViewController *)prevScreen;
-(void)setDisplayItems:(SHSectorDTO *)model;
@property (copy,nonatomic) void (^onSectorSelectionAction)(NSString*);
@end
