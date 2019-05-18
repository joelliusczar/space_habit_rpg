//
//  SHDailyValidation.c
//  SHModels
//
//  Created by Joel Pridgen on 5/18/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#include "SHDailyValidation.h"


int32_t shFilterRate(int32_t rate){
  if(rate > 366){
      return 366;
  }
  if(rate < 1){
      return 1;
  }
  return rate;
}


int32_t shCheckImportanceRange(int32_t importance){
    if(importance > 10){
        return 10;
    }
    if(importance < 0){
        return 0;
    }
    return importance;
}
