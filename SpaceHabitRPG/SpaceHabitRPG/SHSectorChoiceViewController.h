//
//  SectorChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSectorDescriptionViewController.h"
#import "SHCentralViewController.h"
#import <UIKit/UIKit.h>
#import <SHModels/SHSector.h>
#import <SHControls/SHSwitch.h>
#import <SHModels/SHSectorDTO.h>
#import <SHControls/SHButton.h>
#import <SHModels/SHStoryItemObjectID.h>

@class SHSectorDescriptionViewController;

@interface SHSectorChoiceViewController : UIViewController <UITableViewDataSource>
@property (weak,nonatomic) IBOutlet UITableView *sectorChoiceTable;
@property (strong,nonatomic) SHSectorDescriptionViewController *descViewController;
@property (copy,nonatomic) void (^onSelectionAction)(SHStoryItemObjectID*);
-(instancetype)initWithSectorIDs:(NSArray<SHStoryItemObjectID*>*)objectIDs
	withOnSelectionAction:(void (^)(SHStoryItemObjectID*))onSelectionAction;
@end
