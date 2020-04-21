//
//	SHGenAlgos.c
//	SHUtils_C
//
//	Created by Joel Pridgen on 4/28/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHGenAlgos.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>

int64_t calcStrHash(char const *str){
	int64_t hash = 7;
	int32_t idx = 0;
	int32_t prime = 31;
	while(str[idx] != '\0'){
		hash += hash*prime + str[idx++];
	}
	return hash;
}

double blockoptimization kahanSum(const double* const nums, int64_t len){
	double sum = nums[0];
	double excess = 0.0;
	for(int64_t i = 1;i < len;i++){
		double added = sum + nums[i];
		if(fabs(sum) < fabs(nums[i])){
			excess += (sum - added) + nums[i];
		}
		else{
			excess += (nums[i] - added) + sum;
		}
		sum = added;
	}
	return sum + excess;
}


char * shStrCopy(const char * const str) {
	uint64_t len = strlen(str) + 1;
	char *copy = malloc(sizeof(char) * len);
	strcpy(copy,str);
	return copy;
}
