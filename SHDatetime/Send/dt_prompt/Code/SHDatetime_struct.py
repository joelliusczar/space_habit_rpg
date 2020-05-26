from ctypes import c_int
from ctypes import c_bool
from ctypes import c_int64
from ctypes import c_double
from ctypes import POINTER
from ctypes import Structure
from ctypes import CFUNCTYPE
from ctypes import c_char_p
from ctypes import c_void_p
from ctypes import c_uint64

class SHTimeshift(Structure):
	_fields_ = [("month",c_int),
		("day",c_int),
		("hour",c_int),
		("minute",c_int),
		("adjustment",c_int),
		("filler",c_uint64*8)]

class SHDatetime(Structure):
	_fields_ = [("year",c_int64),
		("timestamp",c_double),
		("timeOfDay",c_double),
		("shifts",POINTER(SHTimeshift)),
		("month",c_int),
		("day",c_int),
		("hour",c_int),
		("minute",c_int),
		("second",c_int),
		("milisecond",c_int),
		("timezoneOffset",c_int),
		("shiftLen",c_int),
		("currentShiftIdx",c_int),
		("isTimestampValid",c_bool),
		("filler",c_uint64*8)]


def make_dt_copy(dt):
	copy = SHDatetime(dt.year,dt.month,dt.day,dt.hour,
	dt.minute,dt.second)
	copy.timezoneOffset = dt.timezoneOffset
	copy.shifts = dt.shifts
	copy.shiftLen = dt.shiftLen
	copy.currentShiftIdx = dt.currentShiftIdx
	return copy

def formatDateStr(dt):
	return "y:{} m:{} d:{}".format(dt.year,dt.month,dt.day)

