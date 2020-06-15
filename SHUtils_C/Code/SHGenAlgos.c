//
//	SHGenAlgos.c
//	SHUtils_C
//
//	Created by Joel Pridgen on 4/28/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHGenAlgos.h"
#include "SHUtilConstants.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>

int64_t SH_calcStrHash(char const *str){
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


char * SH_constStrCopy(const char * const str) {
	uint64_t len = strlen(str);
	char *copy = malloc(sizeof(char) * (len + SH_NULL_CHAR_OFFSET)); //plus one for \0 char
	strcpy(copy,str);
	return copy;
}


int32_t SH_bitCount(int64_t num) {
	int32_t count = 0;
	while(num) {
		count += num & 1;
		num >>= 1;
	}
	return count;
}


int32_t SH_highestBit(uint64_t num) {
	if(num == 0) return 0;
	for(int32_t i = 0; i < 64; i++) {
		
	}
}


void SH_swapStrs(char **A, char **B) {
	char *tmp = *A;
	*A = *B;
	*B = tmp;
}


void SH_reverseStrArr(char **arr, uint64_t start, uint64_t end) {
	uint64_t mid = ((end - start) / 2) + start;
	for(uint64_t idx = start; idx < mid; idx++) {
		SH_swapStrs(&arr[idx], &arr[end]);
		end--;
	}
}


void SH_rotateStrArray(char **arr, uint64_t len, uint64_t offset) {
	if(0 == offset || offset > len) return;
	SH_reverseStrArr(arr, 0, len - 1);
	SH_reverseStrArr(arr, 0, offset - 1);
	SH_reverseStrArr(arr, offset, len - 1);
}
