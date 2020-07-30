//
//  SHHabitCell.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import SHControls;
@import SHUtils_C;
@import SHModels;

NS_ASSUME_NONNULL_BEGIN

@interface SHHabitCell : SHTaskCell
@property (assign, nonatomic) struct SHSerialQueue *dbQueue; //not owner
@property (assign, nonatomic) struct SHTableHabit *tableHabit; //not owner
@property (assign, nonatomic) const struct SHTableChangeActions *tableChangeActions; //not owner
-(void)setupCell:(struct SHTableHabit *)tableHabit;
@end

NS_ASSUME_NONNULL_END
