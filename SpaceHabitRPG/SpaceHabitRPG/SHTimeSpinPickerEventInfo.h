//
//  SHTimeSpinPickerEventInfo.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
@import SHControls;

@interface SHTimeSpinPickerEventInfo : SHEventInfo
@property (nonatomic) NSInteger selectedHourRow;
@property (nonatomic) NSInteger selectedMinRow;
@property (nonatomic) NSInteger selectedDaysBeforeRow;
@end
