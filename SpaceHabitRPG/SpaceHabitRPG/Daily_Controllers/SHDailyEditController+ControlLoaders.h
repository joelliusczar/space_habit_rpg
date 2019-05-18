//
//  SHDailyEditController+ControlLoaders.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHDailyEditController.h"
#import <SHCommon/SHControlKeep.h>
#import <SHModels/SHDailyDTO.h>

@interface SHDailyEditController (ControlLoaders)
-(SHControlKeep *)buildControlKeep;
-(void)setResponders:(SHControlKeep *)keep;
@end

