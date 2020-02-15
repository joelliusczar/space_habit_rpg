//
//	SHHero+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHHero.h"
@import SHCommon;


static NSString* const BACKEND_KEY = @"hero_data";

@interface SHHero ()
@property (strong, nonatomic) NSMutableDictionary *backend;
@property (strong, nonatomic) NSURL *saveUrl;
@end

@implementation SHHero


-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil{
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_backend = [resourceUtil getPListMutableDict:BACKEND_KEY];
		_resourceUtil = resourceUtil;
		if(nil == _backend) {
			_backend = [NSMutableDictionary dictionary];
		}
	}
	return self;
}


-(NSDictionary *)mapable{
	return [NSDictionary dictionaryWithDictionary:self.backend];
}


-(NSInteger)gold {
	NSNumber *tmp = (NSNumber*)self.backend[@"gold"];
	NSInteger gold = nil != tmp ? tmp.integerValue : 0;
	return gold;
}


-(void)setGold:(NSInteger)gold {
	self.backend[@"gold"] = @(gold);
}


-(NSInteger)lvl {
	NSNumber *tmp = (NSNumber*)self.backend[@"lvl"];
	NSInteger lvl = nil != tmp ? tmp.integerValue : 1;
	return lvl;
}


-(void)setLvl:(NSInteger)lvl {
	self.backend[@"lvl"] = @(lvl);
}


-(NSInteger)maxHp {
	NSNumber *tmp = (NSNumber*)self.backend[@"maxHp"];
	NSInteger maxHp = nil != tmp ? tmp.integerValue : 50;
	return maxHp;
}


-(void)setMaxHp:(NSInteger)maxHp {
	self.backend[@"maxHp"] = @(maxHp);
}


-(NSInteger)nowHp {
	NSNumber *tmp = (NSNumber*)self.backend[@"nowHp"];
	NSInteger nowHp = nil != tmp ? tmp.integerValue : 50;
	return nowHp;
}


-(void)setNowHp:(NSInteger)nowHp {
	self.backend[@"nowHp"] = @(nowHp);
}


-(NSInteger)maxXp {
	NSNumber *tmp = (NSNumber*)self.backend[@"maxXp"];
	NSInteger maxXp = nil != tmp ? tmp.integerValue : 100;
	return maxXp;
}


-(void)setMaxXp:(NSInteger)maxXp {
	self.backend[@"maxXp"] = @(maxXp);
}


-(NSInteger)nowXp {
	NSNumber *tmp = (NSNumber*)self.backend[@"nowXp"];
	NSInteger nowXp = nil != tmp ? tmp.integerValue : 0;
	return nowXp;
}


-(void)setNowXp:(NSInteger)nowXp {
	self.backend[@"nowXp"] = @(nowXp);
}


-(void)saveToFile {
	[self.resourceUtil saveDict:self.backend toFile:self.saveUrl];
}


-(NSString*)debugDescription {
		NSString *desc = [NSString stringWithFormat:@"Lvl: %ld\n"
	"NowHp: %ld\n"
	"MaxHp: %ld\n"
	"gold: %ld\n"
	"nowXp: %ld\n"
	"maxXp: %ld\n"
	,self.lvl
	,self.nowHp
	,self.maxHp
	,self.gold
	,self.nowXp
	,self.maxXp];
	
	return desc;
}

@end
