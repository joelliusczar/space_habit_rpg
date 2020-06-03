from ctypes import cdll
from ctypes import c_int64
from ctypes import c_int
from ctypes import byref
from ctypes import c_bool
from ctypes import POINTER
from ctypes import c_char_p
from ctypes import c_void_p
from ctypes import c_double
from ctypes import pointer
import os
import sys
os.chdir(os.path.dirname(os.path.abspath(__file__)))
sys.path.append( "../")
from dt_prompt.SHDatetime_struct import *
from sh_due_date_structs import SHWeekIntervalPoint, SHWeekIntervalPointList, SHDueDateWeeklyContext

lib = cdll.LoadLibrary('./libSH_Collection.so')


def buildWeekOfActiveDays(seed):
	week = SHWeekIntervalPointList()
	i = 0
	while seed > 0 and i < 7:
		isActive = seed % 2 == 1
		week.days[i].isDayActive = c_bool(isActive)
		seed /= 2
		i += 1
	return week

def nextDueDate_WEEKLY(lastDueDate,checkinDate, weekSeed, scaler):

	intervalPoints = buildWeekOfActiveDays(weekSeed)
	
	context = SHDueDateWeeklyContext(savedPrevDate = pointer(lastDueDate),
		intervalPoints = pointer(intervalPoints),
		intervalSize = c_int(scaler)
	)
	ans = SHDatetime()
	
	success = lib.SH_nextDueDate_WEEKLY(byref(checkinDate),byref(context),byref(ans))
	print(success)


if __name__ == "__main__":
	lastDueDate = SHDatetime(year = 1978,month = 1, day = 1)
	checkinDate = SHDatetime(year = 1978,month = 1, day = 2)
	nextDueDate_WEEKLY(lastDueDate, checkinDate, 2, 1)

