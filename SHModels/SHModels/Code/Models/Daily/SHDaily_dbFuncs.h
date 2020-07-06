//
//  SHDaily_dbFuncs.h
//  SHModels
//
//  Created by Joel Pridgen on 5/28/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_dbFuncs_h
#define SHDaily_dbFuncs_h

#include <stdio.h>
#include <sqlite3.h>
/*
	SHDB_selectSavedUseDate:
	0: lastActivationDateTime nullable
	1: tzOffsetLastActivationDateTime,
	2: activeFromDateTime nullable,
	3: tzOffsetLastUpdateDateTime,
	4: lastUpdateDateTime,
	5: activeFromHasPriority,
	6: lastUpdateHasPriority
	
	result: one of either lastActivationDatetime, activeFromDateTime, or lastUpdateDateTime
*/
void SHDB_selectSavedUseDate(sqlite3_context* context,int argc,sqlite3_value** values);


/*
	SHDB_nextDueDate:
	0: bithash
	1: useDate (this should be today's date)
	2: prevUseDate (this be whatever was returned from SHDB_selectSavedUseDate)
	3: localTimezoneOffset
*/
void SHDB_nextDueDate(sqlite3_context* context, int argc, sqlite3_value** values);

/*
	SHDB_isDateActive:
	0: bithash
	1: useDate (this should be today's date)
	2: prevUseDate (this be whatever was returned from SHDB_selectSavedUseDate)
	3: localTimezoneOffset
*/
void SHDB_isDateActive(sqlite3_context* context, int argc, sqlite3_value** values);

/*
	SHDB_missedDays:
	0: bithash
	1: useDate (this should be today's date)
	2: prevUseDate (this be whatever was returned from SHDB_selectSavedUseDate)
	3: localTimezoneOffset
*/
void SHDB_missedDays(sqlite3_context* context, int argc, sqlite3_value** values);

/*
	SHDB_penalty:
	0: bithash
	1: useDate (this should be today's date)
	2: prevUseDate (this be whatever was returned from SHDB_selectSavedUseDate)
	3: localTimezoneOffset
	4: urgency
	5: difficulty
	6: monster attack mod
	7: hero def mod
*/
void SHDB_penalty(sqlite3_context* context,int argc, sqlite3_value** values);

/*
	SHDB_getDueStatus:
	0: bithash
	1: useDate (this should be today's date)
	2: prevUseDate (this be whatever was returned from SHDB_selectSavedUseDate)
	3: localTimezoneOffset
*/
void SHDB_getDueStatus(sqlite3_context* context, int argc, sqlite3_value** values);
#endif /* SHDaily_dbFuncs_h */
