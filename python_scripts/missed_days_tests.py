import sys
from datetime import date

def testFormat(year, month, day):
	dt = date(year, month, day)
	test=f"""
	//{dt.strftime("%A")}
	testDate = (struct SHDatetime){{.year = {year}, .month = {month}, .day = {day}, .timezoneOffset = -18000}};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, _);

	"""
	return test


monthCounts = [31,28,31,30,31,30,31,31,30,31,30,31]

with open("output.txt","a") as text_file:

	for m in range(12):
		for d in range(monthCounts[m]):
			text_file.write(testFormat(2018, m + 1, d + 1))