//
//  SHModelConstants.h
//  SHModels
//
//  Created by Joel Pridgen on 5/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDBDueDateConstants_h
#define SHDBDueDateConstants_h


typedef enum {
	SH_IS_NOT_DUE = 0,
	SH_IS_COMPLETED = 1 << 0,
	SH_IS_DUE = 1 << 1,
} SHDueDateStatus;


typedef enum {
		SH_GAME_STATE_UNINITIALIZED = 0,
		SH_GAME_STATE_INTRO_FINISHED = 1,
		SH_GAME_STATE_INTRO_FINISHED_INITIAL_STORY = 2,
		SH_GAME_STATE_INITIALIZED = 3
} SHGameState;


typedef enum {
	SH_STORY_STATE_PROLOGUE = 0,
	SH_STORY_STATE_SECTOR_WAITING = 1,
	SH_STORY_STATE_SECTOR_CHOICE_WAITING = 2,
	SH_STORY_STATE_MONSTER_WAITING = 3,
	SH_STORY_STATE_NORMAL = 4,
} SHStoryState;


typedef enum {
	SH_STORY_MODE_FULL = 1,
	SH_STORY_MODE_NO_MONSTERS = 2,
	SH_STORY_MODE_NO_BATTLE = 4
} SHStoryMode;
#endif /* SHDBDueDateConstants_h */