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
#include <stdlib.h>
#include <string.h>



char * SH_buildWeekDescription(int32_t weekHash) {
	weekHash &= 127; //remove any bits beyond the 7th
	if(127 == weekHash) {
		char * result = malloc(sizeof(char) * 10);
		strcpy(result, "Every Day");
		return result;
	}
	int32_t bitCount = SH_bitCount(weekHash);
	char *result = malloc(sizeof(char) * bitCount * (5)); //5 = 3(day abbrev) + 1 (comma) + 1 (space)
	*result = 0;
	for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK && 0 < bitCount; idx++) {
		if(idx & weekHash) {
			strcat(result, SH_WEEKDAYS[idx]);
			bitCount--;
			if(bitCount > 0) {
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
		char *result = malloc(sizeof(char) * (weekDescLen + 25));
		sprintf(result, "Every week for %s", weekDesc);
		free(weekDesc);
		return result;
	}
	char pluralWeekFrmt[35];
	sprintf(pluralWeekFrmt,"Every %d Weeks", intervalSize);
	char *result = malloc(sizeof(char) * (weekDescLen + 35));
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
	return NULL;
}


char * (*SH_selectDescriptionBuilderFunc(SHIntervalType intervalType))(int32_t,struct SHActiveDaysValues *) {
	
	if(intervalType == SH_WEEKLY_INTERVAL) {
		return _buildIntervalDescription_WEEKLY;
	}
	return NULL;
}
