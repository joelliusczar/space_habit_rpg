//
//  C_Exp.c
//  ObjCPlayground
//
//  Created by Joel Pridgen on 4/19/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "C_Exp.h"

void arrayExps(void){
    const char * const words[3] = {"Hello","Freak","Bitches"};
    const char * words2[3] = {"Hello2","Freak2","Bitches2"};
    char * const words3[3] = {"Hello3","Freak3","Bitches3"};
    
    char * replace = "Censored";
    //words3[2] = replace; //read-only
    words3[2][0] = 'W';
    //words2[2][0] = 'W'; //read-only
    words2[2] = replace;
    
    
}
