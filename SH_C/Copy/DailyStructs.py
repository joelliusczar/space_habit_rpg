from ctypes import Structure
from ctypes import c_longlong
from ctypes import c_bool

class RateValueItem(Structure):
  _fields_ = [("isDayActive",c_bool),
    ("backrange",c_longlong),
    ("forrange",c_longlong)]
