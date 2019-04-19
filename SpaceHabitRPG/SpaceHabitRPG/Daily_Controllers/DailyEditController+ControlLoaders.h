//
//  DailyEditController+ControlLoaders.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyEditController.h"
#import <SHCommon/SHControlKeep.h>

@interface DailyEditController (ControlLoaders)
-(SHControlKeep *)buildControlKeep:(SHDaily *)daily;
-(void)setResponders:(SHControlKeep *)keep;
@end

