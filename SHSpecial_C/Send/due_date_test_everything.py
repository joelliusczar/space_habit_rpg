from ctypes import cdll
from ctypes import c_int64
from ctypes import c_int
from ctypes import byref
from ctypes import c_bool
from ctypes import POINTER
from ctypes import pointer
from ctypes import c_char_p
from ctypes import c_void_p
from ctypes import c_double
import os
import sys
os.chdir(os.path.dirname(os.path.abspath(__file__)))
sys.path.append( "../")
from dt_prompt.SHDatetime_struct import *
from sh_due_date_structs import SHWeekIntervalPoint, SHWeekIntervalPointList, SHDueDateWeeklyContext

lib = cdll.LoadLibrary('./libSH_Collection.so')


def dbg_func(msg):
	print("\nIn debug callback: {}".format(msg))


def is_a_lt_b(fromDate,toDate):
	ans = c_bool(False)
	status = lib.SH_isDateALTDateB(byref(fromDate), byref(toDate), byref(ans))
	if status != 0:
		raise RuntimeError("process failed is_a_lt_b")
	return ans.value

def is_a_same_as_b(fromDate,toDate):
	ans = c_bool(False)
	status = lib.SH_areDatesEqual(byref(fromDate), byref(toDate), byref(ans))
	if status != 0:
		raise RuntimeError("process failed is_a_same_as_b")
	return ans.value

def is_a_lte_b(fromDate, toDate):
	ans = c_bool(False)
	status = lib.SH_isDateALTEDateB(byref(fromDate), byref(toDate), byref(ans))
	if status != 0:
		raise RuntimeError("process failed is_a_lte_b")
	return ans.value

def is_a_gte_b(fromDate, toDate):
	ans = c_bool(False)
	status = lib.SH_isDateAGTEDateB(byref(fromDate), byref(toDate), byref(ans))
	if status != 0:
		raise RuntimeError("process failed is_a_gte_b")
	return ans.value

def is_a_gt_b(fromDate, toDate):
	ans = c_bool(False)
	status = lib.SH_isDateAGTDateB(byref(fromDate), byref(toDate), byref(ans))
	if status != 0:
		raise RuntimeError("process failed is_a_gt_b")
	return ans.value
	
def get_day_diff(fromDate, toDate):
	ans = c_int64(0)
	status = lib.SH_dateDiffDays(byref(fromDate), byref(toDate), byref(ans))
	if status != 0:
		raise RuntimeError("process failed get_day_diff")
	return ans.value

def doAllStartDays(fromDate,toDate):
	error = c_int(0)
	while is_a_lt_b(fromDate, toDate):
		fromCopy = make_dt_copy(fromDate)
		doAllCheckinDays(fromCopy,toDate)
		lib.SH_addDaysToDt(byref(fromDate),c_int(1),c_int(0))


def doAllCheckinDays(fromDate,toDate):
	lowerBoundDate = make_dt_copy(fromDate)
	useDate = make_dt_copy(fromDate)
	error = c_int(0)
	while is_a_lt_b(useDate, toDate):
		doAllWeekCombos(lowerBoundDate, useDate)
		lib.SH_addDaysToDt(byref(useDate), c_int(1), c_int(0))

def doAllWeekCombos(lowerBoundDate,useDate):
	lastDayIdx = lib.SH_weekdayIdx(byref(lowerBoundDate), c_int(0))
	for i in range(1,128):
		week = buildWeekOfActiveDays(i)
		if week.days[lastDayIdx].isDayActive:
			doAllScalers(lowerBoundDate, useDate, week,i)

def doAllScalers(lowerBoundDate, useDate, week, weekSeed):
	error = c_int(0)
	maxScaler = 100
	dbgFncDef = CFUNCTYPE(None,c_char_p)
	dbgFncPtr = dbgFncDef(dbg_func)
	ans = SHDatetime()
	for s in range(1, maxScaler):
		
		formatStr = "lbDt: {} -- useDt: {} wk: {} range: {}_______"
		
		filledFormatStr = formatStr.format(formatDateStr(lowerBoundDate), formatDateStr(useDate)
		,weekSeed, s)
		
		print(filledFormatStr, end="\r", flush=True)
		if is_a_same_as_b(lowerBoundDate, useDate):
			continue
		context = SHDueDateWeeklyContext(
			savedPrevDate = pointer(lowerBoundDate),
			intervalPoints = pointer(week),
			intervalSize = c_int(s)
		)
		superWeek = build_week_for_linear_calc(week,s)
		debugWeek = [b.isDayActive for b in week.days]
		
		#lib.setDebugCallback(dbgFncPtr)
		success = lib.SH_nextDueDate_WEEKLY(byref(useDate),byref(context), byref(ans))
		
		if success != 0:
			raise RuntimeError("Error calculating next due date")

		dtExpected = find_expected_next_due_date(lowerBoundDate,useDate,superWeek)
		if not is_a_same_as_b(ans, dtExpected):
			print("\n")
			
			
			print("Expected:{}\n Actual: {}\n".format(formatDateStr(dtExpected)
				,formatDateStr(ans)))
			print(debugWeek)
			
			raise RuntimeError("Test failed")


#calculates in linear time what the due date should be and returns that so we can compare
def find_expected_next_due_date(lowerBoundDate,useDate,weeks):

	useDateCopy = make_dt_copy(useDate)
	lib.SH_dtSetToTimeOfDay(byref(useDateCopy), c_int(0))
	
	offset = lib.SH_weekdayIdx(byref(lowerBoundDate), c_int(0))
	upperBoundDate = SHDatetime(year = 2100, month = 12, day = 31)
	
	#we base dueDateGuess on lowerBound
	#so that it aligns with days
	dueDateGuess = make_dt_copy(useDateCopy)
	#while dueDateGuess is less than upperBound
	#add days to it
	#if the date is active, then return it. That's our next due date
	days = get_day_diff(lowerBoundDate, useDateCopy)
	while is_a_lt_b(dueDateGuess, upperBoundDate):
		#print("Finding next due date {0:_<82}".format(currentTs),end="\r",flush=True)
		dueDateGuess = make_dt_copy(lowerBoundDate)
		lib.SH_addDaysToDt(byref(dueDateGuess), c_int64(days), c_int(0))
		lib.SH_dtSetToTimeOfDay(byref(dueDateGuess), c_int(0))
		
		if is_a_gte_b(dueDateGuess, useDateCopy):
			if weeks[(days + offset) % len(weeks)]:
				return dueDateGuess
		days += 1
	raise RuntimeError("No next due date found")


def build_week_for_linear_calc(week,scaler):
	superWeek = [b.isDayActive for b in week.days]
	scaler -= 1
	superWeek.extend(False for b in range(7*scaler))
	return superWeek


def buildWeekOfActiveDays(seed):
	week = SHWeekIntervalPointList()
	i = 0
	while seed > 0 and i < 7:
		isActive = seed % 2 == 1
		week.days[i].isDayActive = c_bool(isActive)
		seed /= 2
		i += 1
	return week

if __name__ == "__main__":
	lib.SH_weekdayIdx.restype = c_int
	fromDate = SHDatetime(year = c_int64(2006), month = c_int(1), day = c_int(1))
	toDate = SHDatetime(year = c_int64(2017), month = c_int(12), day = c_int(31),
		hour = c_int(23), minute = c_int(59), second = c_int(59))
	print("Start___________________________",end="\r",flush=True)
	doAllStartDays(fromDate,toDate)

