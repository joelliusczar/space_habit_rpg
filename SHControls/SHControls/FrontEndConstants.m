//
//  FrontEndConstants.m
//  SHControls
//
//  Created by Joel Pridgen on 12/15/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "FrontEndConstants.h"


//column widths
int const HOUR_PICKER_COL_WIDTH = 35;
int const MIN_PICKER_COL_WIDTH = 40;
int const AM_PM_PICKER_COL_WIDTH = 45;
int const LEFTOVER_PICKER_COL_WIDTH = 200;

//picker columns and rows
int const HOUR_OF_DAY_COL = 0;
int const MINUTE_COL = 1;
int const DAYS_BEFORE_COL_IN_24_HOUR_CLOCK = 2;
int const DAYS_BEFORE_COL_IN_12_HOUR_CLOCK = 3;
int const AM_PM_COL = 2;
int const AM_ROW = 0;
int const PM_ROW = 1;

//control heights
CGFloat const SUB_TABLE_CELL_HEIGHT = 44;
NSInteger const SUB_TABLE_MAX_ROWS = 4;
CGFloat const SUB_TABLE_MAX_HEIGHT = SUB_TABLE_CELL_HEIGHT*SUB_TABLE_MAX_ROWS;
CGFloat const ZONE_CHOICE_ROW_HEIGHT = 61;
CGFloat const EDIT_SCREEN_TOP_CONTROL_HEIGHT = 60;


//timings
NSTimeInterval const CHARACTER_DELAY = .01;
NSTimeInterval const SCROLL_DELAY = .001;
CGFloat const SCROLL_INCREMENT = .1;
