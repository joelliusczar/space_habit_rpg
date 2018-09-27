from ctypes import cdll
from ctypes import c_longlong
from ctypes import c_int
from ctypes import byref
from ctypes import c_bool
from ctypes import POINTER
from SHDatetime_struct import Timeshift, SHDatetime, make_dt_copy,formatDateStr
from DailyStructs import RateValueItem

lib = cdll.LoadLibrary('./SH_C/libshTop.so')
dtlib = cdll.LoadLibrary('./SH_C/libSHDatetime.so')

def doAllStartDays(fromDate,toDate):
  while fromDate.year <= toDate.year:
    fromCopy = make_dt_copy(fromDate)
    doAllCheckinDays(fromCopy,toDate)
    error = c_int(0)
    dtlib.tryAddDaysToDtInPlace(byref(fromDate),c_int(1),c_int(0),byref(error))

def doAllCheckinDays(fromDate,toDate):
  startDate = make_dt_copy(fromDate)
  while fromDate.year <= toDate.year:
    doAllWeekCombos(startDate,fromDate,toDate)
    error = c_int(0)
    dtlib.tryAddDaysToDtInPlace(byref(fromDate),c_int(1),c_int(0),byref(error))

def doAllWeekCombos(startDate,checkinDate,endDate):
  for i in range(1,128):
    week = buildWeekOfActiveDays(i)
    error = c_int(0)
    doAllScalers(startDate,checkinDate,endDate,week,i)

def doAllScalers(startDate,checkinDate,endDate,week,weekSeed):
  maxScaler = dtlib.dateDiffDays(byref(startDate),byref(endDate),byref(error))
  for s in range(1,maxScaler):
    ans = SHDatetime()
    error = c_int(0)
    rvi = RateValueItem * 7
    formatStr = "startDate: {} -- checkindate"
      ": {} week: {} scaler: {}_______"
      filledFormatStr = formatStr.format(formatDateStr(startDate),formatDateStr(checkinDate)
      ,reverse("{0:b}".format(weekSeed)),s)
    print(filledFormatStr,end="\r",flush=True)
    lib.buildWeek(byref(week),c_longlong(s),byref(rvi))
    success = lib.nextDueDate_WEEKLY(byref(startDate),byref(checkinDate),byref(rvi)
      ,c_longlong(s),byref(ans),byref(error))
    if not success:
      raise RuntimeError("Error calculating next due date")
    ansTs = dtlib.dtToTimestamp(byref(ans),byref(error)).value
    dtExpected = findNextDueDate(startDate,checkinDate,week,s)
    if ansTs != dtlib.dtToTimestamp(byref(dtExpected),byref(error)):
      
      print("Expected:{}\n Actual: {}\n".format(formatDateStr(dtExpected)
        ,formatDateStr(ans)))
      raise RuntimeError("Test failed")

def findNextDueDate(startDate,checkinDate,week,scaler):
  error = c_int(0)
  days = 1
  tmpDate = make_dt_copy(startDate)
  ts = dtlib.dtToTimestamp(dtlib.dayStart(byref(make_dt_copy(checkinDate)))).value
  superWeek = buildSuperWeek(week,scaler)
  offset = dtlib.calcWeekdayIdx(byref(tmpDate),byref(error))
  limit = dtlib.dtToTimestamp(dtlib.dayStart(byref(SHDatetime(9999,12,31,0,0,0))),byref(error))
  added = SHDatetime()
  currentTs = 0
  while currentTs < limit:
    dtlib.tryAddDaysToDt(byref(startDate),c_longlong(days),c_int(0),byref(added),byref(error))
    currentTs = dtlib.dtToTimestamp(dtlib.dayStart(byref(added)),byref(error))
    if currentTs > ts:
      if superWeek[(day + offset) % len(superWeek)]:
        return added
    days += 1
  raise RuntimeError("No next due date found")


def buildSuperWeek(week,scaler):
  superWeek = [b.value for b in week]
  scaler -= 1
  while scaler > 0:
    superWeek.extend(False for b in range(7))
  return superWeek


def buildWeekOfActiveDays(seed):
  week = c_bool * 7
  i = 0
  while seed > 0 and i < 7:
    isActive = seed % 2 == 1
    week[i] = c_bool(isActive)
    seed /= 2
    i += 1
  return week

if __name__ == "__main__":
  lib.nextDueDate_WEEKLY.restype = c_bool
  dtlib.calcWeekdayIdx.restype = c_int
  dtlib.dayStart.restype = POINTER(SHDatetime)
  dtlib.dtToTimestamp.restype = c_longlong
  SHDatetime fromDate = SHDatetime()
  fromDate.year = c_longlong(1978)
  fromDate.month = c_int(1)
  fromDate.day = c_int(1)
  fromDate.hour = c_int(0)
  fromDate.minute = c_int(0)
  fromDate.second = c_int(0)
  fromDate.milisecond = c_int(0)
  fromDate.timezoneOffset = c_int(0)
  
  SHDatetime toDate = SHDatetime()
  toDate.year = c_longlong(2102)
  toDate.month = c_int(12)
  toDate.day = c_int(31)
  toDate.hour = c_int(23)
  toDate.minute = c_int(59)
  toDate.second = c_int(59)
  toDate.milisecond = c_int(0)
  toDate.timezoneOffset = c_int(0)
  
  doAllStartDays(fromDate,toDate)

