//
//  PureCBaby.c
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/4/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "PureCBaby.h"

void RocketZoom(){
	printf("zoom\n");
}

void subber(){
	printf("Subbed!");
}

void Hijack(){
	void (*fpt)(void);
	fpt = &RocketZoom;
	fpt();
	
}
