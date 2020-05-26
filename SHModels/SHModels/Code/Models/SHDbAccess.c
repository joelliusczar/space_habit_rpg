//
//  SHDbAccess.c
//  SHModels
//
//  Created by Joel Pridgen on 5/22/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDbAccess.h"

sqlite3 *db = NULL;
pthread_t dbSerialThread = {0};
