//
//  DateHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+DateHelper.h"
#import "SingletonCluster.h"
#import "NSDate+testReplace.h"
#import "NSLocale+Helper.h"

@interface DateHelperTest : XCTestCase

@end

@implementation DateHelperTest

- (void)setUp {
    [super setUp];
    SharedGlobal.inUseTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    SharedGlobal.inUseLocale = NSLocale.autoupdatingCurrentLocale;
    [super tearDown];
}


-(void)testCreateDate{
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:35 second:12];
    XCTAssertEqual(testDate.timeIntervalSince1970, 578165712);
}


-(void)testAdjustDateYear{
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:35 second:12];
    NSDate *result = [NSDate adjustDate:testDate year:9 month:0 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 862162512);
    result = [NSDate adjustDate:testDate year:-8 month:0 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 325704912);
}


-(void)testAdjustDateMonth{
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:16 hour:13 minute:35 second:12];
    NSDate *result = [NSDate adjustDate:testDate year:0 month:2 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 582485712);
    result = [NSDate adjustDate:testDate year:0 month:9 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 600978912);
    
}


-(void)testAdjustDateDay{
//test simple adding
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:35 second:12];
    NSDate *result = [NSDate adjustDate:testDate year:0 month:0 day:2];
    XCTAssertEqual(result.timeIntervalSince1970, 578338512);
//test rollover to next month
    result = [NSDate adjustDate:testDate year:0 month:0 day:4];
    XCTAssertEqual(result.timeIntervalSince1970, 578511312);
//test rollover to next year during a leap year
    result = [NSDate adjustDate:testDate year:0 month:0 day:249];
    XCTAssertEqual(result.timeIntervalSince1970, 599682912);
//test rollover from febuary during leap year
    testDate = [NSDate createDateTime:1988 month:2 day:28 hour:13 minute:35 second:12];
    result = [NSDate adjustDate:testDate year:0 month:0 day:1];
    XCTAssertEqual(result.timeIntervalSince1970, 573158112);
    result = [NSDate adjustDate:testDate year:0 month:0 day:2];
    XCTAssertEqual(result.timeIntervalSince1970, 573244512);
//test rollover from febuary during non leap year
    testDate = [NSDate createDateTime:1989 month:2 day:28 hour:13 minute:35 second:12];
    result = [NSDate adjustDate:testDate year:0 month:0 day:2];
    XCTAssertEqual(result.timeIntervalSince1970, 604866912);
}


-(void)testGetDaysLeft{
    NSDate *fromTime = [NSDate createDateTime:1988 month:4 day:27 hour:0 minute:0 second:0];
    NSDate *toTime = [NSDate createDateTime:1988 month:4 day:28 hour:0 minute:0 second:0];
    int daysLeft = (int)[NSDate daysBetween:fromTime to:toTime];
    XCTAssertEqual(daysLeft,1);
}


-(void)testSwizzleDate{
    testTodayReplacement = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:45 second:40 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    [NSDate swizzleThatShit];
    NSDate *testDate = [NSDate date];
    XCTAssertEqual(testDate.timeIntervalSince1970,testTodayReplacement.timeIntervalSince1970);
    
}


-(void)testCreateSimpleTime{
    NSDate *testDate = [NSDate createSimpleTime:2 minute:0 second:0];
    XCTAssertEqual(testDate.timeIntervalSince1970,7200);
    testDate = [NSDate createSimpleTime:24 minute:1 second:1];
}


-(void)testTimeOfDayInPreferredFormat{
    NSString *result = [NSDate timeOfDayInSystemPreferredFormat:13 andMinute:15];
    XCTAssertTrue([result isEqualToString:@"1:15 PM"]);
    SharedGlobal.inUseLocale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    result = [NSDate timeOfDayInSystemPreferredFormat:13 andMinute:15];
    XCTAssertTrue([result isEqualToString:@"13:15"]);
}


-(void)testIs24Hours{
    NSLocale *testLocale = [NSLocale localeWithLocaleIdentifier:@"mr"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bs"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ee_TG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ms"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kam_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mt"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_HN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ml_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ro_MD"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kab_DZ"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"he"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_CO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"my"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Latn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mer"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_NZ"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"xog_UG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sg"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GP"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl_BA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hi"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fil_PH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lt_LT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"si"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"si_LK"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luo_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"it_CH"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"teo"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mfe"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sk"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Cyrl_UZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rm_CH"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Cyrl_AZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GQ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kde"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sn"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cgg_UG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_RW"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_SV"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mas_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MU"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sq"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hr"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_PH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ca"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hu"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mk_MK"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_TD"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nb"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sv"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kln_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sw"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nd"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"el_GR"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hy"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ne"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"el_CY"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_CR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fo_FO"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Arab_PK"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"seh"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_YE"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ur_PK"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Guru"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gl_ES"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant_HK"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_EG"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"th_TH"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_KM"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kk_Cyrl_KZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kea"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lv_LV"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kln"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tzm_Latn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"yo"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gsw_CH"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn_GH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"is_IS"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_BR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cs"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_PK"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fa_IR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_SG"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luo"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ta"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_TG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kde_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mr_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_SA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ka_GE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mfe_MU"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"id"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_LU"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_LU"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru_MD"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cy"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_HK"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"te"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bg_BG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Latn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ig"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ses"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ii"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_BO"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"th"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ko_KR"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ti"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Latn_MA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_MZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ff_SN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"haw"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bn_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_UM"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"to"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"id_ID"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Cyrl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_GU"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_EC"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn_BA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"is"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luy"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tr"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_NA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"it"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"da"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bo_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vun_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_SD"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Latn_UZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Latn_AZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_GQ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ta_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_DE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rof_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_LY"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_BW"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"asa"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_NE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_MX"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bem_ZM"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bn_BD"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_GW"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"om"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"jmc"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_AT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kk_Cyrl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sw_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_OM"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"et_EE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"or"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"da_DK"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ro_RO"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bm_ML"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ja"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"naq"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zu"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_IE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_MA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_GT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Arab_AF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_AS"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bs_BA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"am_ET"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_TN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"haw_US"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_JO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fa_AF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Latn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_BZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nyn_UG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ebu_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"te_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cy_GB"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uk"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nyn"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_JM"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fil"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_KW"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"af_ZA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_CA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_DJ"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ti_ER"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ig_NG"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_AU"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ur"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MC"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_PT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CD"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_SG"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bo_CN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kn_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl_RS"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lg_UG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gu_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ee"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nd_ZW"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bem"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sw_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sq_AL"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hr_HR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mas_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"el"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ti_ET"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_AR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"eo"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kok"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_RE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mas"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rof"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru_UA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"yo_NG"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"dav_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gv_GB"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Arab"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"teo_UG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ps"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PR"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"et"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"eu"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ka"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rwk_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nb_NO"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cgg"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant_TW"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl_ME"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lag"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ses_ML"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_ZW"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ak_GH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vi_VN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sv_FI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"to_TO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CH"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_CH"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_US"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ki"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"my_MM"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vi"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_QA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ga_IE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rwk"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bez"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ee_GH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kk"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"as_IN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ca_ES"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_SN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ne_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"km"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ms_BN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_LB"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ta_LK"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kn"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ur_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ko"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn_NG"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sg_CF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"om_ET"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant_MO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uk_UA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fa"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mt_MT"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ki_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luy_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kw"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Guru_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kab"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_IQ"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ff"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_TT"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bez_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_NI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Arab"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ne_NP"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fi"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"khq"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gsw"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_MO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hu_HU"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_BE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"saq"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"be_BY"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sl_SI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn_RS"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fo"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"xog"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tzm"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sk_SK"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_ML"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"he_IL"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn_NE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CM"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"teo_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"seh_MZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kl_GL"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fi_FI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kam"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_ES"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"af"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"asa_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cs_CZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tr_TR"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PY"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tzm_Latn_MA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lg"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ebu"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_HK"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nl_NL"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_BE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ms_MY"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_UY"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_BH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kw_GB"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ak"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"chr"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"dav"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lag_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"am"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_DJ"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Tfng_MA"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn_ME"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sn_ZW"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"or_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"as"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"jmc_TZ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"chr_US"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"eu_ES"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"saq_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vun"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lt"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"naq_NA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ga"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"af_NA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kea_CV"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_DO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lv"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kok_IN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_LI"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BJ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"guz_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rw_RW"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mg_MG"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"km_KH"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Tfng"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_AE"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MQ"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rm"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sv_SE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Cyrl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ro"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_ET"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_ZA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ii_CN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BL"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hi_IN"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gu"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mer_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nn_NO"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gv"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_DZ"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_SY"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MP"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nl_BE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rw"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"be"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_VI"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_CL"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bg"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mg"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hy_AM"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zu_ZA"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"guz"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mk"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_VE"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ml"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bm"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"khq_ML"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bn"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ps_AF"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_SO"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pl_PL"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GN"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bo"];
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    
    testLocale = [NSLocale localeWithLocaleIdentifier:@"om_KE"];
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    

}

@end
