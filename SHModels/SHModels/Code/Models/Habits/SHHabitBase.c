//
//  SHHabitBase.c
//  SHModels
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHHabitBase.h"
#include <stdlib.h>


void SH_freeHabitBase(struct SHHabitBase *habit) {
	if(!habit) return;
	free(habit->name);
	free(habit);
}
