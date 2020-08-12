//
//  SHStoryFigure.c
//  SHModels
//
//  Created by Joel Pridgen on 8/9/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHStoryFigure.h"


char const SH_HERO_DATA_LOCATION[9] = "hero_data";
char const SH_MONSTER_DATA_LOCATION[12] = "monster_data";
const float _HERO_LVL_MOD = .5;
const uint32_t _STREAK_MINOR_WEIGHT = 10;
const uint32_t _STREAK_MAJOR_WEIGHT = 100;

/*
	The scoring for this was determined somewhat haphazardly.
*/
int64_t SH_calcHeroAttackCharge(const struct SHHeroAttackChargeComponents *components) {
	if(!components) return 0;
	double result = components->urgency * components->difficulty;
	result *= (components->heroLvl * _HERO_LVL_MOD);
	double streakLengthMajor = components->streakLength;
	double streakLengthMinor = components->streakLength;
	double streakScore = 0;
	if(components->streakLength > 0) {
		if(components->streakLength >= 365) {
			streakLengthMajor = components->streakLength % 365;
			streakLengthMinor = components->streakLength - streakLengthMinor;
			streakScore += streakLengthMinor * _STREAK_MINOR_WEIGHT;
			streakScore += (streakLengthMajor / 365.0) * _STREAK_MAJOR_WEIGHT;
		}
		if(((uint32_t)streakLengthMajor) >= 30) {
			streakLengthMajor = ((uint32_t)streakLengthMajor) % 30;
			streakLengthMinor = (components->streakLength % 365) - streakLengthMinor;
			streakScore += streakLengthMinor * _STREAK_MINOR_WEIGHT;
			streakScore += (streakLengthMajor / 30.0) * _STREAK_MAJOR_WEIGHT;
		}
		if(((uint32_t)streakLengthMajor) >= 7) {
			streakLengthMajor = ((uint32_t)streakLengthMajor) % 7;
			streakLengthMinor = ((components->streakLength % 365) % 7) - streakLengthMinor;
			streakScore += streakLengthMinor * _STREAK_MINOR_WEIGHT;
			streakScore += (streakLengthMajor / 7.0) * _STREAK_MAJOR_WEIGHT;
		}
	}
	result *= streakScore;
	return (int64_t)result;
}
