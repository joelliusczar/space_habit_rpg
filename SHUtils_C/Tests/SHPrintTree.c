//
//  SHPrintTree.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHPrintTree.h"
#include "SHUtilConstants.h"
#include "SHGenAlgos.h"
#include <stdlib.h>

static int32_t nullBreak = -1;
static int32_t lnBreak = -2;

//static char * _itemStr(void *item) {
//	if(!item) return NULL;
//	int32_t num = *((int32_t*)item);
//	if(num == lnBreak) {
//		return SH_constStrCopy("\n");
//	}
//	if(num == nullBreak) {
//		return SH_constStrCopy("X, ");
//	}
//	char *str = malloc(sizeof(char) * 14 + SH_NULL_CHAR_OFFSET);
//	sprintf(str, "%d, ",num);
//	return str;
//}

//
//void SH_tree_printNumbers(struct SHTree *tree) {
//
//	SH_tree_setLineBreakSentinel(tree, &lnBreak);
//	SH_tree_setNullItemSentinel(tree, &nullBreak);
//
//	char *desc = SH_tree_printLineOrder(tree, _itemStr);
//	printf("%s\n",desc);
//	free(desc);
//}
