//
//  SHHabitBase.c
//  SHModels
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHHabitBase.h"
#include <stdlib.h>


void SH_freeHabitBase(struct SHHabitBase **habitP2) {
	if(!habitP2) return;
	struct SHHabitBase *habit = *habitP2;
	if(!habit) return;
	if(habit->name) free(habit->name);
	free(habit);
	*habitP2 = NULL;
}
