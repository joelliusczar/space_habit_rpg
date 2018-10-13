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

def dbg_func(msg):
  print("In debug callback: {}".format(msg))

def doAllStartDays(fromDate,toDate):
  error = c_int(0)
  while lib.dtToTimestamp(byref(fromDate),byref(error)) < lib.dtToTimestamp(byref(toDate),byref(error)):
    fromCopy = make_dt_copy(fromDate)
    doAllCheckinDays(fromCopy,toDate)
    lib.tryAddDaysToDtInPlace(byref(fromDate),c_int(1),c_int(0),byref(error))


def doAllCheckinDays(fromDate,toDate):
  startDate = make_dt_copy(fromDate)
  checkinDate = make_dt_copy(fromDate)
  error = c_int(0)
  lib.tryAddDaysToDtInPlace(byref(checkinDate),c_int(1),c_int(0),byref(error))
  while lib.dtToTimestamp(byref(checkinDate),byref(error)) < lib.dtToTimestamp(byref(toDate),byref(error)):
    doAllWeekCombos(startDate,checkinDate,toDate)
    lib.tryAddDaysToDtInPlace(byref(checkinDate),c_int(1),c_int(0),byref(error))

def doAllWeekCombos(startDate,checkinDate,endDate):
  for i in range(1,128):
    week = buildWeekOfActiveDays(i)
    doAllScalers(startDate,checkinDate,endDate,week,i)

def doAllScalers(startDate,checkinDate,endDate,week,weekSeed):
  error = c_int(0)
  maxScaler = lib.dateDiffDays(byref(endDate),byref(startDate),byref(error))
  dbgFncDef = CFUNCTYPE(None,c_char_p)
  dbgFncPtr = dbgFncDef(dbg_func)
  ans = SHDatetime()
  for s in range(1,maxScaler):
    rviType = RateValueItem * 7
    rvi = rviType()
    
    formatStr = "startDate: {} -- checkindate: {} week: {} scaler: {}_______"
    
    filledFormatStr = formatStr.format(formatDateStr(startDate),formatDateStr(checkinDate)
    ,weekSeed,s)
    
    print(filledFormatStr,end="\r",flush=True)
    lib.buildWeek(byref(week),c_int64(s),byref(rvi))
    errMsg = c_char_p(b"")
    voidObj = c_void_p(None)
    #lib.setDebugCallback(dbgFncPtr)
    myErr = SHError(c_int(0),callbackType(err_callback),errMsg,voidObj,c_bool(False))
    success = lib.nextDueDate_WEEKLY(byref(startDate),byref(checkinDate),byref(rvi)
    ,c_int64(s),byref(ans),byref(myErr))
    
    if not success:
      raise RuntimeError("Error calculating next due date")
    ansTs = lib.dtToTimestamp(byref(ans),byref(error))
    dtExpected = findNextDueDate(startDate,checkinDate,week,s)
    if ansTs != lib.dtToTimestamp(byref(dtExpected),byref(error)):
      print("Expected:{}\n Actual: {}\n".format(formatDateStr(dtExpected)
      ,formatDateStr(ans)))
      
      raise RuntimeError("Test failed")

def findNextDueDate(startDate,checkinDate,week,scaler):
  error = c_int(0)
  myErr = SHError(c_int(0),callbackType(err_callback),c_char_p(b""),c_void_p(None),c_bool(False))
  days = 1
  tmpDate = make_dt_copy(startDate)
  checkinCopy = make_dt_copy(checkinDate)
  checkinDayStart = lib.dayStartInPlace(byref(checkinCopy))
  ts = lib.dtToTimestamp(checkinDayStart,byref(error))
  superWeek = buildSuperWeek(week,scaler)
  offset = lib.calcWeekdayIdx(byref(tmpDate),byref(error))
  limitDt = SHDatetime(9999,12,31,0,0,0)
  limit = lib.dtToTimestamp(byref(limitDt),byref(error))
  added = SHDatetime()
  currentTs = 0
  while currentTs < limit:
    #print("Finding next due date {0:_<82}".format(currentTs),end="\r",flush=True)
    lib.tryAddDaysToDt_m(byref(tmpDate),c_int64(days),c_int(0),byref(added),byref(myErr))
    addedDayStart = lib.dayStartInPlace(byref(added))
    currentTs = lib.dtToTimestamp(addedDayStart,byref(error))
    if currentTs > ts:
      if superWeek[(days + offset) % len(superWeek)]:
        return added
    days += 1
  raise RuntimeError("No next due date found")


def buildSuperWeek(week,scaler):
  superWeek = [b for b in week]
  scaler -= 1
  while scaler > 0:
    superWeek.extend(False for b in range(7))
    scaler -= 1
  return superWeek


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

if __name__ == "__main__":
  lib.nextDueDate_WEEKLY.restype = c_bool
  lib.calcWeekdayIdx.restype = c_int
  lib.dayStartInPlace.restype = POINTER(SHDatetime)
  lib.dtToTimestamp.restype = c_double
  fromDate = SHDatetime(1978,1,1,0,0,0,0,0)
  toDate = SHDatetime(2102,12,31,23,59,59,0,0)
  print("Start___________________________",end="\r",flush=True)
  doAllStartDays(fromDate,toDate)

