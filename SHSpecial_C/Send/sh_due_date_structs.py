from ctypes import Structure
from ctypes import c_int64
from ctypes import c_bool
from ctypes import c_uint64
from ctypes import c_int
from ctypes import POINTER
from dt_prompt.SHDatetime_struct import *

class SHWeekIntervalPoint(Structure):
	_fields_ = [("isDayActive", c_bool),
		("backrange", c_int),
		("forrange", c_int),
		("filler", c_uint64*4)]

class SHWeekIntervalPointList(Structure):
	_fields_ = [("days", SHWeekIntervalPoint * 7)]

class SHDueDateWeeklyContext(Structure):
	_fields_ = [("savedPrevDate", POINTER(SHDatetime)),
		("intervalPoints", POINTER(SHWeekIntervalPointList)),
		("intervalSize", c_int),
		("dayStartHour", c_int),
		("weekStartOffset", c_int),
		("isInverse", c_bool)]
