//
//  SHStoryFigure.h
//  SHModels
//
//  Created by Joel Pridgen on 8/9/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHStoryFigure_h
#define SHStoryFigure_h

#include <SHUtils_C/SHErrorHandling.h>
#include <stdio.h>
#include <inttypes.h>

extern char const SH_HERO_DATA_LOCATION[9];
extern char const SH_MONSTER_DATA_LOCATION[12];

/*
	It is important that the order of the properties in this struct stay unchanged.
*/
struct SHHeroData {
	uint64_t gold;
	uint64_t lvl;
	uint64_t maxHp;
	uint64_t maxXp;
	uint64_t nowHp;
	uint64_t nowXp;
	uint64_t attackCharge;
	uint64_t defence;
	//using a string array because this object will always get saved directly. We don't want to save the address
	char name[256]; //remember to always enforce string length when setting this guy
};


struct SHMonsterData {
	char monsterKey[25];
	uint64_t lvl;
	uint64_t nowHp;
	uint64_t maxHp;
	uint64_t attack;
	uint64_t xp;
	uint64_t defense;
	float treasureDropRate;
	uint64_t encounterWeight;
};

struct SHHeroAttackChargeComponents {
	int32_t urgency;
	int32_t difficulty;
	uint32_t streakLength;
	uint64_t heroLvl;
};

int64_t SH_calcHeroAttackCharge(const struct SHHeroAttackChargeComponents *components);


#endif /* SHStoryFigure_h */
