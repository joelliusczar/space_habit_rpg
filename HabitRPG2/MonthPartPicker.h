//
//  MonthPartPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSpinPicker.h"
#import "P_UtilityStore.h"

@interface MonthPartPicker : SHSpinPicker
@property (weak,nonatomic) id<P_UtilityStore> utilityStore;
@end
