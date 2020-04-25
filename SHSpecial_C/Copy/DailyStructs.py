from ctypes import Structure
from ctypes import c_int64
from ctypes import c_bool
from ctypes import c_uint64

class RateValueItem(Structure):
	_fields_ = [("isDayActive",c_bool),
		("backrange",c_int32),
		("forrange",c_int32),
		("filler",c_uint64*4)]
