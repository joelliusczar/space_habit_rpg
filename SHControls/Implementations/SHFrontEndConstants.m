//
//  FrontEndConstants.m
//  SHControls
//
//  Created by Joel Pridgen on 12/15/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SHFrontEndConstants.h"


//column widths
int const SH_HOUR_PICKER_COL_WIDTH = 35;
int const SH_MIN_PICKER_COL_WIDTH = 40;
int const SH_AM_PM_PICKER_COL_WIDTH = 45;
int const SH_LEFTOVER_PICKER_COL_WIDTH = 200;

//picker columns and rows
int const SH_HOUR_OF_DAY_COL = 0;
int const SH_MINUTE_COL = 1;
int const SH_DAYS_BEFORE_COL_IN_24_HOUR_CLOCK = 2;
int const SH_DAYS_BEFORE_COL_IN_12_HOUR_CLOCK = 3;
int const SH_AM_PM_COL = 2;
int const SH_AM_ROW = 0;
int const SH_PM_ROW = 1;

//control heights
CGFloat const SH_SUB_TABLE_CELL_HEIGHT = 44;
NSInteger const SH_SUB_TABLE_MAX_ROWS = 4;
CGFloat const SH_SUB_TABLE_MAX_HEIGHT = SH_SUB_TABLE_CELL_HEIGHT*SH_SUB_TABLE_MAX_ROWS;
CGFloat const SH_SECTOR_CHOICE_ROW_HEIGHT = 61;
CGFloat const SH_EDIT_SCREEN_TOP_CONTROL_HEIGHT = 60;


//timings
NSTimeInterval const SH_CHARACTER_DELAY = .01;
NSTimeInterval const SH_SCROLL_DELAY = .00005; //smaller -> faster
CGFloat const SH_SCROLL_INCREMENT = .01;
