//
//  SHDbAccess.h
//  SHModels
//
//  Created by Joel Pridgen on 5/22/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDbAccess_h
#define SHDbAccess_h

#include <stdio.h>
#include <sqlite3.h>

extern sqlite3 *db;
extern pthread_t dbSerialThread;

#endif /* SHDbAccess_h */
