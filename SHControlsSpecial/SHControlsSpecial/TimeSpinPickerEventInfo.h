//
//  TimeSpinPickerEventInfo.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHControls/SHEventInfo.h>

@interface TimeSpinPickerEventInfo : SHEventInfo
@property (nonatomic) NSInteger selectedHourRow;
@property (nonatomic) NSInteger selectedMinRow;
@property (nonatomic) NSInteger selectedDaysBeforeRow;
@end
