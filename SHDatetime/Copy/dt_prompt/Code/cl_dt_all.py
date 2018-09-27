from ctypes import cdll
from ctypes import Structure
from ctypes import c_int
from ctypes import c_long
from ctypes import c_double
from ctypes import byref
from ctypes import POINTER
from datetime import datetime, timezone
from SHDatetime_struct import Timeshift, SHDatetime, make_dt_copy
import sys

lib = cdll.LoadLibrary('./libdt.so')


class MonthDay:
    month = 0
    day = 0

    def __init__(self,month,day):
        self.month = month
        self.day = day

def compareDTtoPyDt(dt,pdt):
    if dt.year != pdt.timetuple()[0]:
        return False
    if dt.month != pdt.timetuple()[1]:
        return False
    if dt.day != pdt.timetuple()[2]:
        return False
    if dt.hour != pdt.timetuple()[3]:
        return False
    if dt.minute != pdt.timetuple()[4]:
        return False
    if dt.second != pdt.timetuple()[5]:
        return False
    return True

def testCTimeExhaustive(lowBound,upBound):
    incr = 1 if upBound > lowBound else -1
    error = c_int(0)
    dt = SHDatetime()
    ans = c_double(-1)
    print(lowBound)
    for i in range(lowBound,upBound,incr):
        ts=c_double(i)
        lib.tryTimestampToDt(ts,0,byref(dt),byref(error))
        try:
            pts = datetime.fromtimestamp(i,tz=timezone.utc)
            if not compareDTtoPyDt(dt,pts):
                dateStr = "year {} month:{} day:{}".format(
                dt.year,dt.month,dt.day)
                print("{}___".format(dateStr))
                return -1
            pdt = datetime(dt.year,dt.month,dt.day,dt.hour,dt.minute, dt.second
                ,tzinfo = timezone.utc)
            if error.value:
                print("\ntimestamp to dt ended with error code {}\n".format(error.value))
                print("timestamp: {}".format(ans.value))
                return -1
            lib.tryDtToTimestamp(byref(dt),byref(ans),byref(error))
            if ans.value != pdt.timestamp():
                print("\nresult does not match python timestamp {}\n".format(ans.value))
                return -1
            if error.value:
                print("\ndt to timestamp ended with error code {}\n".format(error.value))
                return -1
            

            if i % 86400 == 0:
                dateStr = "year {} month:{} day:{}".format(
                    dt.year,dt.month,dt.day)
                print("{}___".format(dateStr),end="\r",flush=True)
            if ans.value != i:
                print("\nExpected value: {} actual value: {}\n".format(
                    i,ans.value))
                return -1
        except:
            print(sys.exc_info()[1])
            print("i is: {}".format(i))
            dateStr = "year {} month:{} day:{}".format(
                dt.year,dt.month,dt.day)
            print("{}___".format(dateStr))
            return -1

    return 0



if __name__ == "__main__":
    lowBound = 0
    upBound = sys.maxsize
    if len(sys.argv) > 1:
        lowBound = int(sys.argv[1])
    if len(sys.argv) > 2:
        upBound = int(sys.argv[2])
    exitCode = testCTimeExhaustive(lowBound,upBound)
    if exitCode == 0:
        print("Process done successfully")
    sys.exit(exitCode)
