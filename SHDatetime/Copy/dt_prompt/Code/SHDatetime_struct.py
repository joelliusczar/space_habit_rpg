from ctypes import c_int
from ctypes import c_long
from ctypes import c_double
from ctypes import POINTER


class Timeshift(Structure):
	_fields_ = [("month",c_int),
				("day",c_int),
				("hour",c_int),
				("minute",c_int),
				("adjustment",c_int)]

class SHDatetime(Structure):
	_fields_ = [("year",c_long),
				("month",c_int),
				("day",c_int),
				("hour",c_int),
				("minute",c_int),
				("second",c_int),
				("milisecond",c_int),
				("timezoneOffset",c_int),
				("shifts",POINTER(Timeshift)),
				("shiftLen",c_int),
				("currentShiftIdx",c_int)]
