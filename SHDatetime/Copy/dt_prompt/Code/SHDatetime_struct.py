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

class Timeshift(Structure):
  _fields_ = [("month",c_int),
    ("day",c_int),
    ("hour",c_int),
    ("minute",c_int),
    ("adjustment",c_int),
    ("filler",c_uint64*8)]

class SHDatetime(Structure):
  _fields_ = [("year",c_int64),
    ("month",c_int),
    ("day",c_int),
    ("hour",c_int),
    ("minute",c_int),
    ("second",c_int),
    ("milisecond",c_int),
    ("timezoneOffset",c_int),
    ("shifts",POINTER(Timeshift)),
    ("shiftLen",c_int),
    ("currentShiftIdx",c_int),
    ("filler",c_uint64*8)]

callbackType = CFUNCTYPE(c_bool,c_int,c_char_p,c_void_p,POINTER(c_bool))

class SHError(Structure):
  _fields_=[("code",c_int),
    ("errorCallback",callbackType),
    ("msg",c_char_p),
    ("callbackInfo",c_void_p),
    ("isError",c_bool),
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

