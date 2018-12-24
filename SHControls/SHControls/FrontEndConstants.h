//
//  FrontEndConstants.h
//  SHControls
//
//  Created by Joel Pridgen on 12/15/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

//column widths
extern int const HOUR_PICKER_COL_WIDTH;
extern int const MIN_PICKER_COL_WIDTH;
extern int const AM_PM_PICKER_COL_WIDTH;
extern int const LEFTOVER_PICKER_COL_WIDTH;

//picker columns and rows
extern int const HOUR_OF_DAY_COL;
extern int const MINUTE_COL;
extern int const DAYS_BEFORE_COL_IN_24_HOUR_CLOCK;
extern int const DAYS_BEFORE_COL_IN_12_HOUR_CLOCK;
extern int const AM_PM_COL;
extern int const AM_ROW;
extern int const PM_ROW;

//control heights
extern CGFloat const SUB_TABLE_CELL_HEIGHT;
extern NSInteger const SUB_TABLE_MAX_ROWS;
extern CGFloat const SUB_TABLE_MAX_HEIGHT;
extern CGFloat const ZONE_CHOICE_ROW_HEIGHT;
extern CGFloat const EDIT_SCREEN_TOP_CONTROL_HEIGHT;

//timings
extern NSTimeInterval const CHARACTER_DELAY;
extern NSTimeInterval const SCROLL_DELAY;
extern CGFloat const SCROLL_INCREMENT;
