from ctypes import cdll
from ctypes import c_int64
from ctypes import c_int
from ctypes import byref
from ctypes import c_bool
from ctypes import POINTER
from ctypes import c_char_p
from ctypes import c_void_p
from ctypes import c_double
import os
import sys
os.chdir(os.path.dirname(os.path.abspath(__file__)))
sys.path.append( "../")
from SHDatetime.SHDatetime_struct import *
from DailyStructs import RateValueItem

lib = cdll.LoadLibrary('./libshTop.so')

def err_callback(err,msg,info,isError):
	print("In err callback: {}".format(msg))

def buildWeekOfActiveDays(seed):
	weekType = c_bool * 7
	week = weekType()
	i = 0
	while seed > 0 and i < 7:
		isActive = seed % 2 == 1
		week[i] = c_bool(isActive)
		seed /= 2
		i += 1
	return week

def nextDueDate_WEEKLY(lastDueDate,checkinDate,weekSeed,scaler):
	errMsg = c_char_p(b"")
	voidObj = c_void_p(None)
	intervalPointsType = RateValueItem * 7
	intervalPoints = intervalPointsType()
	week = buildWeekOfActiveDays(weekSeed)
	ans = SHDatetime()
	myErr = SHError(c_int(0),callbackType(err_callback),errMsg,voidObj,c_bool(False))
	lib.buildWeek(byref(week),c_int64(scaler),byref(intervalPoints))
	success = lib.nextDueDate_WEEKLY(byref(lastDueDate),byref(checkinDate),byref(intervalPoints)
	,c_int64(scaler),byref(ans),byref(myErr))
	print(success)

if __name__ == "__main__":
	lib.nextDueDate_WEEKLY.restype = c_bool
	lib.calcWeekdayIdx.restype = c_int
	lib.dayStartInPlace.restype = POINTER(SHDatetime)
	lib.dtToTimestamp.restype = c_double
	lastDueDate = SHDatetime(1978,1,1,0,0,0,0,0)
	checkinDate = SHDatetime(1978,1,2,0,0,0,0,0)
	nextDueDate_WEEKLY(lastDueDate,checkinDate,2,1)

