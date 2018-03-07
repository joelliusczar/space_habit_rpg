//
//  TestLocale.m
//  HabitRPG2Tests
//
//  Created by Joel Pridgen on 1/6/18.
//  Copyright © 2018 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/NSDate+DateHelper.h>
#import "NSDate+testReplace.h"
#import <SHCommon/NSLocale+Helper.h>
@import TestCommon;

@interface TestLocale : FrequentCase

@end

@implementation TestLocale

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testIs24Hours{
    NSLocale *testLocale = [NSLocale localeWithLocaleIdentifier:@"mr"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bs"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ee_TG"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ms"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kam_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mt"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_HN"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ml_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ro_MD"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kab_DZ"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"he"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_CO"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"my"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PA"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Latn"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mer"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_NZ"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"xog_UG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sg"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GP"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl_BA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hi"];//a h
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fil_PH"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lt_LT"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"si"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MT"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"si_LK"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luo_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"it_CH"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"teo"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mfe"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sk"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Cyrl_UZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rm_CH"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Cyrl_AZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GQ"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kde"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sn"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cgg_UG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_RW"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_SV"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mas_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MU"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sq"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hr"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_PH"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ca"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hu"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mk_MK"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_TD"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nb"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sv"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kln_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sw"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nd"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"el_GR"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hy"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ne"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"el_CY"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_CR"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fo_FO"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Arab_PK"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"seh"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_YE"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];//H時
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ur_PK"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Guru"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gl_ES"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant_HK"];//ah時
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_EG"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"th_TH"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_KM"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nn"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kk_Cyrl_KZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kea"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lv_LV"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kln"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tzm_Latn"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"yo"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gsw_CH"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn_GH"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"is_IS"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_BR"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cs"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_PK"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fa_IR"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_SG"];//ah时
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luo"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ta"];//a h
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_TG"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kde_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mr_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_SA"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ka_GE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mfe_MU"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"id"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_LU"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_LU"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru_MD"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cy"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_HK"];//ah时
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"te"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bg_BG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Latn"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ig"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ses"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ii"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_BO"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"th"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ko_KR"];//a h시
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ti"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Latn_MA"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_MZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ff_SN"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"haw"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans"];//ah时
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bn_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_UM"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"to"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"id_ID"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Cyrl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_GU"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_EC"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn_BA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"is"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luy"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tr"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_NA"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"it"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"da"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bo_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vun_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_SD"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Latn_UZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Latn_AZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_GQ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ta_IN"];//a h
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_DE"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rof_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_LY"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_BW"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"asa"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh"];//ah时
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_NE"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_MX"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bem_ZM"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];//ah时
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bn_BD"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_GW"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"om"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"jmc"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_AT"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kk_Cyrl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sw_TZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_OM"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"et_EE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"or"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"da_DK"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ro_RO"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant"];//ah時
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bm_ML"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ja"];//H時
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CA"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"naq"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zu"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_IE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_MA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_GT"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Arab_AF"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_AS"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bs_BA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"am_ET"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_TN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"haw_US"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_JO"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fa_AF"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Latn"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_BZ"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nyn_UG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ebu_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"te_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cy_GB"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uk"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nyn"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_JM"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_US"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fil"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_KW"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"af_ZA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_CA"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_DJ"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ti_ER"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ig_NG"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_AU"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ur"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MC"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt_PT"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CD"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_SG"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bo_CN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kn_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl_RS"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lg_UG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gu_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ee"];//a 'ga' h
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nd_ZW"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bem"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sw_KE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sq_AL"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hr_HR"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mas_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"el"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ti_ET"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_AR"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"eo"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kok"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CF"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_RE"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mas"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rof"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru_UA"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"yo_NG"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"dav_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gv_GB"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Arab"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"teo_UG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ps"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PR"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MF"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"et"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pt"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"eu"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ka"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rwk_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nb_NO"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CG"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cgg"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant_TW"];//ah時
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl_ME"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lag"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ses_ML"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_ZW"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ak_GH"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vi_VN"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sv_FI"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"to_TO"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MG"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GA"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CH"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_CH"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_US"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ki"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"my_MM"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vi"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_QA"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ga_IE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rwk"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bez"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ee_GH"];//a 'ga' h
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kk"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"as_IN"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ca_ES"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_SN"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ne_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"km"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ms_BN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_LB"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ta_LK"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kn"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ur_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CI"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ko"];//a h시
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn_NG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sg_CF"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"om_ET"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant_MO"];//ah時
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uk_UA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fa"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mt_MT"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ki_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"luy_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kw"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pa_Guru_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kab"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_IQ"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ff"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_TT"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bez_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_NI"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"uz_Arab"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ne_NP"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fi"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"khq"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gsw"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_MO"];//ah时
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MH"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hu_HU"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BE"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_BE"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"saq"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"be_BY"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sl_SI"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn_RS"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fo"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"xog"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BF"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tzm"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sk_SK"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_ML"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"he_IL"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ha_Latn_NE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru_RU"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_CM"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"teo_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"seh_MZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kl_GL"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fi_FI"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kam"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_ES"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"af"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"asa_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"cs_CZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tr_TR"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_PY"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"tzm_Latn_MA"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lg"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ebu"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_HK"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nl_NL"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_BE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ms_MY"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_UY"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_BH"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kw_GB"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ak"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"chr"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"dav"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lag_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"am"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_DJ"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Tfng_MA"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Latn_ME"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sn_ZW"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"or_IN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"as"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BI"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"jmc_TZ"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"chr_US"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"eu_ES"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"saq_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"vun"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lt"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"naq_NA"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ga"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"af_NA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kea_CV"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_DO"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"lv"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"kok_IN"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"de_LI"];//HH 'Uhr'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BJ"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"guz_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rw_RW"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mg_MG"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"km_KH"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"shi_Tfng"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_AE"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_MQ"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rm"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sv_SE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"az_Cyrl"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ro"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_ET"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_ZA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ii_CN"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_BL"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hi_IN"];//a h
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gu"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mer_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nn_NO"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"gv"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ru"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_DZ"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ar_SY"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_MP"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"nl_BE"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"rw"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"be"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"en_VI"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_CL"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bg"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mg"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"hy_AM"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"zu_ZA"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"guz"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"mk"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"es_VE"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ml"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bm"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"khq_ML"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bn"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"ps_AF"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"so_SO"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"sr_Cyrl"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"pl_PL"];//HH
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"fr_GN"];//HH 'h'
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"bo"];//h a
    XCTAssertFalse(testLocale.isUsing24HourFormat);
    testLocale = [NSLocale localeWithLocaleIdentifier:@"om_KE"];//H
    XCTAssertTrue(testLocale.isUsing24HourFormat);
    
}


@end
