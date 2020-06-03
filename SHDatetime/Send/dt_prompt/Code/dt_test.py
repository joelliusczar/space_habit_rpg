import pytest
from pytest import approx
import copy
from SHDatetime_struct import SHDatetime
from SHDatetime_struct import SHTimeshift
from SHDatetime_struct import make_dt_copy
import ctypes
from ctypes import cdll
from ctypes import c_long
from ctypes import c_int
from ctypes import byref
from ctypes import c_double


HOUR_IN_SECONDS = 3600

@pytest.fixture(scope="module")
def lib():
	lib = cdll.LoadLibrary("./libdt.so")
	return lib

@pytest.fixture
def tz_offset():
	tz_offset = -18000
	return tz_offset

def test_create_date(tz_offset,lib):
	ans = c_double(0)
	dt = SHDatetime()
	lib.SH_dtSetYear(byref(dt), c_long(1970))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtSetTimezoneOffset(byref(dt), c_int(tz_offset))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 18000
	lib.SH_dtSetYear(byref(dt), c_long(1970))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(27))
	lib.SH_dtSetHour(byref(dt), c_int(13))
	lib.SH_dtSetMinute(byref(dt), c_int(35))
	lib.SH_dtSetSecond(byref(dt), c_int(12))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 2313312
	lib.SH_dtSetYear(byref(dt), c_long(1988))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(13))
	lib.SH_dtSetHour(byref(dt), c_int(14))
	lib.SH_dtSetMinute(byref(dt), c_int(27))
	lib.SH_dtSetSecond(byref(dt), c_int(15))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 569100435
	lib.SH_dtSetYear(byref(dt), c_long(1997))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 852094800
	lib.SH_dtSetYear(byref(dt), c_long(1988))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(28))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 573022800
	lib.SH_dtSetYear(byref(dt), c_long(1988))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(29))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 573109200
	tz_offset = -14400
	lib.SH_dtSetYear(byref(dt), c_long(1988))
	lib.SH_dtSetMonth(byref(dt), c_int(4))
	lib.SH_dtSetDay(byref(dt), c_int(27))
	lib.SH_dtSetHour(byref(dt), c_int(13))
	lib.SH_dtSetMinute(byref(dt), c_int(35))
	lib.SH_dtSetSecond(byref(dt), c_int(12))
	lib.SH_dtSetTimezoneOffset(byref(dt), c_int(tz_offset))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 578165712
	lib.SH_dtSetYear(byref(dt), c_long(1997))
	lib.SH_dtSetMonth(byref(dt), c_int(4))
	lib.SH_dtSetDay(byref(dt), c_int(27))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 862113600
	tz_offset = 0
	lib.SH_dtSetYear(byref(dt), c_long(1972))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(29))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtSetTimezoneOffset(byref(dt), c_int(tz_offset))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 68169600
	lib.SH_dtSetYear(byref(dt), c_long(1972))
	lib.SH_dtSetMonth(byref(dt), c_int(3))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 68256000
	lib.SH_dtSetYear(byref(dt), c_long(1973))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(14))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 98496000
	lib.SH_dtSetYear(byref(dt), c_long(2038))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(19))
	lib.SH_dtSetHour(byref(dt), c_int(3))
	lib.SH_dtSetMinute(byref(dt), c_int(14))
	lib.SH_dtSetSecond(byref(dt), c_int(7))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == 2147483647
	lib.SH_dtSetYear(byref(dt), c_long(1969))
	lib.SH_dtSetMonth(byref(dt), c_int(12))
	lib.SH_dtSetDay(byref(dt), c_int(31))
	lib.SH_dtSetHour(byref(dt), c_int(23))
	lib.SH_dtSetMinute(byref(dt), c_int(59))
	lib.SH_dtSetSecond(byref(dt), c_int(59))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -1
	lib.SH_dtSetYear(byref(dt), c_long(1969))
	lib.SH_dtSetMonth(byref(dt), c_int(12))
	lib.SH_dtSetDay(byref(dt), c_int(31))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -86400
	lib.SH_dtSetYear(byref(dt), c_long(1901))
	lib.SH_dtSetMonth(byref(dt), c_int(12))
	lib.SH_dtSetDay(byref(dt), c_int(13))
	lib.SH_dtSetHour(byref(dt), c_int(20))
	lib.SH_dtSetMinute(byref(dt), c_int(45))
	lib.SH_dtSetSecond(byref(dt), c_int(52))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -2147483648
	lib.SH_dtSetYear(byref(dt), c_long(1969))
	lib.SH_dtSetMonth(byref(dt), c_int(3))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -26438400
	lib.SH_dtSetYear(byref(dt), c_long(1969))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(28))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -26524800
	lib.SH_dtSetYear(byref(dt), c_long(1968))
	lib.SH_dtSetMonth(byref(dt), c_int(3))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -57974400
	lib.SH_dtSetYear(byref(dt), c_long(1968))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(28))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -58147200
	lib.SH_dtSetYear(byref(dt), c_long(1968))
	lib.SH_dtSetMonth(byref(dt), c_int(2))
	lib.SH_dtSetDay(byref(dt), c_int(29))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -58060800
	lib.SH_dtSetYear(byref(dt), c_long(1967))
	lib.SH_dtSetMonth(byref(dt), c_int(4))
	lib.SH_dtSetDay(byref(dt), c_int(27))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))

	assert ans.value == -84672000

def test_timestampToDt(lib):
	dt = SHDatetime()
	
	lib.SH_timestampToDt(c_double(-2051222400),c_int(0),byref(dt))
	assert dt.year == 1905
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-2082844800),c_int(0),byref(dt))
	assert dt.year == 1904
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-126230399),c_int(0),byref(dt))
	assert dt.year == 1966
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 1
	
	lib.SH_timestampToDt(c_double(-2145916799),c_int(0),byref(dt))
	assert dt.year == 1902
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 1
	
	lib.SH_timestampToDt(c_double(157766399),c_int(0),byref(dt))
	assert dt.year == 1974
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-126230400),c_int(0),byref(dt))
	assert dt.year == 1966
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-2145916800),c_int(0),byref(dt))
	assert dt.year == 1902
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(68256000),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 3
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(94694400),c_int(0),byref(dt))
	assert dt.year == 1973
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-63158401),c_int(0),byref(dt))
	assert dt.year == 1967
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(126230399),c_int(0),byref(dt))
	assert dt.year == 1973
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(126230400),c_int(0),byref(dt))
	assert dt.year == 1974
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(136252800),c_int(0),byref(dt))
	assert dt.year == 1974
	assert dt.month == 4
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(252460800),c_int(0),byref(dt))
	assert dt.year == 1978
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(94694399),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-63158400),c_int(0),byref(dt))
	assert dt.year == 1968
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(63158400),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 1
	assert dt.day == 2
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(0),c_int(0),byref(dt))
	assert dt.year == 1970
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(1),c_int(0),byref(dt))
	assert dt.year == 1970
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 1
	
	lib.SH_timestampToDt(c_double(2851200),c_int(0),byref(dt))
	assert dt.year == 1970
	assert dt.month == 2
	assert dt.day == 3
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(31449600),c_int(0),byref(dt))
	assert dt.year == 1970
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-31536000),c_int(0),byref(dt))
	assert dt.year == 1969
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(63071999),c_int(0),byref(dt))
	assert dt.year == 1971
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(230947200),c_int(0),byref(dt))
	assert dt.year == 1977
	assert dt.month == 4
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(65318400),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 1
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(68083200),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 2
	assert dt.day == 28
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(68169600),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 2
	assert dt.day == 29
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(68256000),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 3
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(73180800),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 4
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(220924800),c_int(0),byref(dt))
	assert dt.year == 1977
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(956793600),c_int(0),byref(dt))
	assert dt.year == 2000
	assert dt.month == 4
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(1009756799),c_int(0),byref(dt))
	assert dt.year == 2001
	assert dt.month == 12
	assert dt.day == 30
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(1009670400),c_int(0),byref(dt))
	assert dt.year == 2001
	assert dt.month == 12
	assert dt.day == 30
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(1009843199),c_int(0),byref(dt))
	assert dt.year == 2001
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(199411200),c_int(0),byref(dt))
	assert dt.year == 1976
	assert dt.month == 4
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(191548800),c_int(0),byref(dt))
	assert dt.year == 1976
	assert dt.month == 1
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(220838400),c_int(0),byref(dt))
	assert dt.year == 1976
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(2147483647),c_int(0),byref(dt))
	assert dt.year == 2038
	assert dt.month == 1
	assert dt.day == 19
	assert dt.hour == 3
	assert dt.minute == 14
	assert dt.second == 7
	
	lib.SH_timestampToDt(c_double(63072000),c_int(0),byref(dt))
	assert dt.year == 1972
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-31536000),c_int(0),byref(dt))
	assert dt.year == 1969
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-384780),c_int(0),byref(dt))
	assert dt.year == 1969
	assert dt.month == 12
	assert dt.day == 27
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-31536001),c_int(0),byref(dt))
	assert dt.year == 1968
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-31920780),c_int(0),byref(dt))
	assert dt.year == 1968
	assert dt.month == 12
	assert dt.day == 27
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-63543180),c_int(0),byref(dt))
	assert dt.year == 1967
	assert dt.month == 12
	assert dt.day == 27
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-91191180),c_int(0),byref(dt))
	assert dt.year == 1967
	assert dt.month == 2
	assert dt.day == 10
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-95079180),c_int(0),byref(dt))
	assert dt.year == 1966
	assert dt.month == 12
	assert dt.day == 27
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-126615180),c_int(0),byref(dt))
	assert dt.year == 1965
	assert dt.month == 12
	assert dt.day == 27
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-189773580),c_int(0),byref(dt))
	assert dt.year == 1963
	assert dt.month == 12
	assert dt.day == 27
	assert dt.hour == 13
	assert dt.minute == 7
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-86400),c_int(0),byref(dt))
	assert dt.year == 1969
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-86401),c_int(0),byref(dt))
	assert dt.year == 1969
	assert dt.month == 12
	assert dt.day == 30
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-1),c_int(0),byref(dt))
	assert dt.year == 1969
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-53049600),c_int(0),byref(dt))
	assert dt.year == 1968
	assert dt.month == 4
	assert dt.day == 27
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-2208988800),c_int(0),byref(dt))
	assert dt.year == 1900
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4107542400),c_int(0),byref(dt))
	assert dt.year == 2100
	assert dt.month == 3
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4102444800),c_int(0),byref(dt))
	assert dt.year == 2100
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4133980799),c_int(0),byref(dt))
	assert dt.year == 2100
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(4165430399),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 12
	assert dt.day == 30
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(4165344000),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 12
	assert dt.day == 30
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4165430400),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4165516799),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(4165516800),c_int(0),byref(dt))
	assert dt.year == 2102
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4260124800),c_int(0),byref(dt))
	assert dt.year == 2104
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4260211199),c_int(0),byref(dt))
	assert dt.year == 2104
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(4260211200),c_int(0),byref(dt))
	assert dt.year == 2105
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4102358399),c_int(0),byref(dt))
	assert dt.year == 2099
	assert dt.month == 12
	assert dt.day == 30
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(4102358400),c_int(0),byref(dt))
	assert dt.year == 2099
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4102444799),c_int(0),byref(dt))
	assert dt.year == 2099
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(4133980800),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4139078400),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 3
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4138992000),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 2
	assert dt.day == 28
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(4134067200),c_int(0),byref(dt))
	assert dt.year == 2101
	assert dt.month == 1
	assert dt.day == 2
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(7289654400),c_int(0),byref(dt))
	assert dt.year == 2201
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(7289740800),c_int(0),byref(dt))
	assert dt.year == 2201
	assert dt.month == 1
	assert dt.day == 2
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(7294752000),c_int(0),byref(dt))
	assert dt.year == 2201
	assert dt.month == 3
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(10445328000),c_int(0),byref(dt))
	assert dt.year == 2301
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(10445414400),c_int(0),byref(dt))
	assert dt.year == 2301
	assert dt.month == 1
	assert dt.day == 2
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(13569465600),c_int(0),byref(dt))
	assert dt.year == 2400
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(13601087999),c_int(0),byref(dt))
	assert dt.year == 2400
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(13601088000),c_int(0),byref(dt))
	assert dt.year == 2401
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-2208988801),c_int(0),byref(dt))
	assert dt.year == 1899
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-2240524800),c_int(0),byref(dt))
	assert dt.year == 1899
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-8520336001),c_int(0),byref(dt))
	assert dt.year == 1699
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-11644473601),c_int(0),byref(dt))
	assert dt.year == 1600
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-11673417601),c_int(0),byref(dt))
	assert dt.year == 1600
	assert dt.month == 1
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-11676009602),c_int(0),byref(dt))
	assert dt.year == 1600
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 58
	
	lib.SH_timestampToDt(c_double(-11676096001),c_int(0),byref(dt))
	assert dt.year == 1599
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-11707632000),c_int(0),byref(dt))
	assert dt.year == 1599
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 0
	assert dt.minute == 0
	assert dt.second == 0
	
	lib.SH_timestampToDt(c_double(-11802240001),c_int(0),byref(dt))
	assert dt.year == 1596
	assert dt.month == 1
	assert dt.day == 1
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(-14831769601),c_int(0),byref(dt))
	assert dt.year == 1499
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	
	lib.SH_timestampToDt(c_double(253402300799),c_int(0),byref(dt))
	assert dt.year == 9999
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59


def test_add_days_to_ts(lib):
	ts = c_double(578102400)
	dt = SHDatetime()
	ans = c_double(0)
	error = c_int(0)
	lib.SH_timestampToDt(ts, c_int(0), byref(dt))
	
	lib.SH_addDaysToDt(byref(dt), c_long(0), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))
	assert ts.value == ans.value
	
	lib.SH_timestampToDt(ts, c_int(0), byref(dt))
	lib.SH_addDaysToDt(byref(dt), c_long(1), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))
	
	assert 578188800 == ans.value
	
	lib.SH_timestampToDt(ts, c_int(0), byref(dt))
	lib.SH_addDaysToDt(byref(dt), c_long(-1), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))
	assert 578016000 == ans.value
	
	lib.SH_timestampToDt(ts, c_int(0), byref(dt))
	lib.SH_addDaysToDt(byref(dt), c_long(4), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(ans))
	assert 578448000 == ans.value

def test_DecimalTime(lib):
	dt = SHDatetime(year = 2018,month = 3,day = 9,timezoneOffset = 0,
			hour = 2, minute = 13, second = 0, milisecond = 96)
	precision = .0001
	error = c_int(0)
	timestamp = c_double(0)
	lib.SH_dtToTimestamp(byref(dt), byref(timestamp))
	
	lib.SH_dtSetYear(byref(dt), c_long(9999))
	lib.SH_dtSetMonth(byref(dt), c_int(12))
	lib.SH_dtSetDay(byref(dt), c_int(31))
	lib.SH_dtSetHour(byref(dt), c_int(23))
	lib.SH_dtSetMinute(byref(dt), c_int(59))
	lib.SH_dtSetSecond(byref(dt), c_int(59))

	lib.SH_dtToTimestamp(byref(dt), byref(timestamp))
	assert timestamp.value == approx(253402300799.096,abs = precision)
	
	lib.SH_timestampToDt(c_double(253402300799.096), c_int(0), byref(dt))
	assert dt.year == 9999
	assert dt.month == 12
	assert dt.day == 31
	assert dt.hour == 23
	assert dt.minute == 59
	assert dt.second == 59
	assert dt.milisecond == 96
	
	lib.SH_dtSetYear(byref(dt), c_long(1969))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(timestamp))
	assert timestamp.value == approx(-31536000.096,abs = precision)
	
	lib.SH_dtSetYear(byref(dt), c_int(1))
	lib.SH_dtSetMonth(byref(dt), c_int(1))
	lib.SH_dtSetDay(byref(dt), c_int(1))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	lib.SH_dtSetSecond(byref(dt), c_int(0))
	lib.SH_dtToTimestamp(byref(dt), byref(timestamp))
	assert timestamp.value == approx(-62135596800.096,abs = precision)

def test_dayOfYear(lib):
	dt = SHDatetime()
	lib.SH_timestampToDt(c_double(10022400), c_int(0), byref(dt))
	result = lib.SH_calcDayOfYear(byref(dt))
	assert result == 117
	lib.SH_timestampToDt(c_double(73180800), c_int(0), byref(dt))
	result = lib.SH_calcDayOfYear(byref(dt))
	assert result == 118
	lib.SH_timestampToDt(c_double(5097600), c_int(0), byref(dt))
	result = lib.SH_calcDayOfYear(byref(dt))
	assert result == 60
	lib.SH_timestampToDt(c_double(68256000), c_int(0), byref(dt))
	result = lib.SH_calcDayOfYear(byref(dt))
	assert result == 61
	lib.SH_timestampToDt(c_double(68169600), c_int(0), byref(dt))
	result = lib.SH_calcDayOfYear(byref(dt))
	assert result == 60
	lib.SH_timestampToDt(c_double(5011200), c_int(0), byref(dt))
	result = lib.SH_calcDayOfYear(byref(dt))
	assert result == 59
	

def test_add_days_to_dt(lib):
	tsArr = SHTimeshift * 2
	dst = tsArr(
			SHTimeshift(3, 11, 2, 0, HOUR_IN_SECONDS),
			SHTimeshift(11, 4, 2, 0, 0))
	error = c_int(0)
	dt = SHDatetime(year = 2018,month = 3,day = 9,timezoneOffset = -5 * HOUR_IN_SECONDS,
		hour = 2, minute = 13, second = 0)
	dt.shifts = dst
	dt.shiftLen = len(dst)
	dt.currentShiftIdx = lib.SH_selectTimeShiftIdxForDt(byref(dt), dst, c_int(dt.shiftLen))
	dt_copy = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(dt_copy), c_long(2), c_int(0))
	assert dt_copy.day == 11
	assert dt_copy.hour == 3
	assert dt_copy.minute == 13
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-4
	lib.SH_dtSetHour(byref(dt), c_int(1))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(2), c_int(0))
	assert dt_copy.day == 11
	assert dt_copy.hour == 1
	assert dt_copy.minute == 13
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-5
	lib.SH_dtSetHour(byref(dt), c_int(1))
	lib.SH_dtSetMinute(byref(dt), c_int(59))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(2), c_int(0))
	assert dt_copy.day == 11
	assert dt_copy.hour == 1
	assert dt_copy.minute == 59
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-5
	lib.SH_dtSetHour(byref(dt), c_int(2))
	lib.SH_dtSetMinute(byref(dt), c_int(0))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(2), c_int(0))
	assert dt_copy.day == 11
	assert dt_copy.hour == 3
	assert dt_copy.minute == 0
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-4
	
	lib.SH_dtSetHour(byref(dt), c_int(3))
	lib.SH_dtSetMinute(byref(dt), c_int(1))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(2), c_int(0))
	assert dt_copy.day == 11
	assert dt_copy.hour == 3
	assert dt_copy.minute == 1
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-4
	
	dt_copy = make_dt_copy(dt)
	
	lib.SH_dtSetHour(byref(dt), c_int(6))
	lib.SH_addDaysToDt(byref(dt_copy), c_long(3), c_int(0))
	assert dt_copy.day == 12
	assert dt_copy.hour == 3
	assert dt_copy.minute == 1
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-4
	
	dt.timezoneOffset = -4*HOUR_IN_SECONDS
	lib.SH_dtSetMonth(byref(dt), c_int(11))
	lib.SH_dtSetDay(byref(dt), c_int(3))
	lib.SH_dtSetHour(byref(dt), c_int(0))
	lib.SH_dtSetMinute(byref(dt), c_int(1))
	dt.currentShiftIdx = lib.SH_selectTimeShiftIdxForDt(byref(dt), dst, c_int(dt.shiftLen))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(1), c_int(0))
	assert dt_copy.day == 4
	assert dt_copy.hour == 0
	assert dt_copy.minute == 1
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-4
	
	lib.SH_dtSetHour(byref(dt), c_int(2))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(1), c_int(0))
	assert dt_copy.day == 4
	assert dt_copy.hour == 1
	assert dt_copy.minute == 1
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-5
	
	lib.SH_dtSetHour(byref(dt), c_int(3))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(1), c_int(0))
	assert dt_copy.day == 4
	assert dt_copy.hour == 3
	assert dt_copy.minute == 1
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-5
	
	lib.SH_dtSetHour(byref(dt), c_int(2))
	dt_copy = make_dt_copy(dt)
	
	lib.SH_addDaysToDt(byref(dt_copy), c_long(2), c_int(0))
	assert dt_copy.day == 5
	assert dt_copy.hour == 2
	assert dt_copy.minute == 1
	assert dt_copy.timezoneOffset == HOUR_IN_SECONDS*-5

def test_add_years_to_dt(lib):
	tz_offset = c_int(-14400)
	dt = SHDatetime(year = 1988, month = 4, day = 27, hour = 13, minute = 35, second = 12, timezoneOffset = tz_offset)
	tmp = make_dt_copy(dt)
	error = c_int(0)
	ans = c_double(0)
	
	lib.SH_addYearsToDt(byref(tmp),c_long(9),c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 862162512
	tmp = make_dt_copy(dt)
	lib.SH_addYearsToDt(byref(tmp),c_long(-8),c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	
	assert ans.value == 325704912

def test_add_month_to_dt(lib):
	tz_offset = c_int(-18000)
	dt = SHDatetime(year = 1988, month = 4, day = 16, hour = 13, minute = 35, second = 12, timezoneOffset = tz_offset)
	tmp = make_dt_copy(dt)
	ans = c_double(0)
	
	lib.SH_addMonthsToDt(byref(tmp), c_long(2), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 582489312
	
	tmp = make_dt_copy(dt)
	lib.SH_addMonthsToDt(byref(tmp), c_long(9), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 600978912


def test_add_days_to_dt_2(lib):
	#test simple adding
	tz_offset = c_int(-18000)
	ans = c_double(0)
	dt = SHDatetime(year = 1988, month = 4, day = 27, hour = 13, minute = 35, second = 12, timezoneOffset = tz_offset)
	
	tmp = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(tmp), c_long(2), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	
	assert ans.value == 578342112
#test rollover to next month

	tmp = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(tmp), c_long(4), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 578514912
#test rollover to next year during a leap year

	tmp = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(tmp), c_long(249), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 599682912
#test rollover from febuary during leap year
	dt = SHDatetime(year = 1988, month = 2, day = 28, hour = 13, minute = 35, second = 12, timezoneOffset = tz_offset)
	
	tmp = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(tmp), c_long(1), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 573158112
	
	tmp = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(tmp),c_long(2),c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))
	assert ans.value == 573244512
	
#test rollover from febuary during non leap year
	dt = SHDatetime(year = 1989, month = 2, day = 28, hour = 13, minute = 35, second = 12, timezoneOffset = tz_offset)
	
	tmp = make_dt_copy(dt)
	lib.SH_addDaysToDt(byref(tmp), c_long(2), c_int(0))
	lib.SH_dtToTimestamp(byref(tmp), byref(ans))

	assert ans.value == 604866912


def test_days_between(lib):
	fromTime = SHDatetime(year = 1988, month = 4, day = 27)
	toTime = SHDatetime(year = 1988, month = 4, day = 28)
	daysLeft = c_int(0)
	lib.SH_dateDiffDays(byref(fromTime), byref(toTime), byref(daysLeft))
	assert daysLeft.value == 1
