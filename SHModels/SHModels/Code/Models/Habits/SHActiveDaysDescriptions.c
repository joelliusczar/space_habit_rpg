//
//  SHActiveDaysDescriptions.c
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHActiveDaysDescriptions.h"
#include <SHDatetime/SHDTConstants.h>
#include <SHUtils_C/SHGenAlgos.h>
#include <SHUtils_C/SHUtilConstants.h>
#include <stdlib.h>
#include <string.h>



char * SH_buildWeekDescription(int32_t weekHash) {
	weekHash &= SH_FULL_WEEK_HASH; //remove any bits beyond the 7th
	if(SH_FULL_WEEK_HASH == weekHash) {
		return SH_constStrCopy("Every Day");
	}
	int32_t activeDayCount = SH_bitCount(weekHash);
	
	//5 = 3(day abbrev) + 1 (comma) + 1 (space),
	//+ 1 for NULL terminator
	const int32_t dayNameLen = 3;
	const int32_t commaAndSpace = 2;
	const int32_t extra = dayNameLen + commaAndSpace;
	char *result = malloc(sizeof(char) * ((activeDayCount * extra) + SH_NULL_CHAR_OFFSET));
	result = SH_constStrCopy("");
	for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK && 0 < activeDayCount; idx++) {
		if(idx & weekHash) {
			strcat(result, SH_WEEKDAYS[idx]);
			activeDayCount--;
			if(activeDayCount > 0) {
				strcat(result, ", ");
			}
		}
	}
	return result;
}


char * SH_buildIntervalLabelDescription_week(int32_t weekHash, int32_t intervalSize) {
	char * weekDesc = SH_buildWeekDescription(weekHash);
	uint64_t weekDescLen = strlen(weekDesc);
	if(intervalSize == 1){
		int32_t baseStrLen = 17; //"Every week for %s" len
		char *result = malloc(sizeof(char) * (weekDescLen + baseStrLen + SH_NULL_CHAR_OFFSET));
		sprintf(result, "Every week for %s", weekDesc);
		free(weekDesc);
		return result;
	}
	int32_t pluralFrmtLen = 35; // str len + len of max int
	char pluralWeekFrmt[pluralFrmtLen];
	sprintf(pluralWeekFrmt,"Every %d Weeks", intervalSize);
	char *result = malloc(sizeof(char) * (weekDescLen + pluralFrmtLen + SH_NULL_CHAR_OFFSET));
	sprintf(result, "%s for %s", pluralWeekFrmt, weekDesc);
	free(weekDesc);
	return result;
}


static char * _buildIntervalDescription_WEEKLY(int32_t intervalSize, struct SHActiveDaysValues *activeDays) {
	return SH_buildIntervalLabelDescription_week(activeDays->weekIntervalHash, intervalSize);
}


char * SH_selectIntervalDescription(struct SHActiveDaysValues *activeDays) {
	if(activeDays->intervalType == SH_WEEKLY_INTERVAL) {
		return SH_buildIntervalLabelDescription_week(activeDays->weekIntervalHash, activeDays->weekIntervalSize);
	}
	return SH_constStrCopy("");
}


char * (*SH_selectDescriptionBuilderFunc(SHIntervalType intervalType))(int32_t,struct SHActiveDaysValues *) {
	
	if(intervalType == SH_WEEKLY_INTERVAL) {
		return _buildIntervalDescription_WEEKLY;
	}
	return NULL;
}
