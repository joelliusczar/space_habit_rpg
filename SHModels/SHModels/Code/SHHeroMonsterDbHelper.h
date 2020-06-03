//
//  SHHeroMonsterDbHelper.h
//  SHModels
//
//  Created by Joel Pridgen on 5/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHHeroMonsterDbHelper_h
#define SHHeroMonsterDbHelper_h

#include <stdio.h>

struct SHHeroMonsterDbHelper {
	double (*monsterAttackModifier)(void);
	double (*heroDefenceModifier)(void);
};

#endif /* SHHeroMonsterDbHelper_h */
