//
//  SHMonster.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonsterInfoDictionary.h"
#import "SHStoryItemProtocol.h"
@import Foundation;
@import CoreData;
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHMonster : NSObject<SHStoryItemProtocol>
@property (class,strong,nonatomic) SHMonsterInfoDictionary *monsterInfo;
@property (strong, nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (copy, nonatomic) NSString *monsterKey;
@property (assign,nonatomic) NSInteger lvl;
@property (assign,nonatomic) NSInteger nowHp;
@property (readonly,nonatomic) NSInteger maxHp;
@property (readonly,nonatomic) NSInteger attack;
@property (readonly,nonatomic) NSInteger xp;
@property (readonly,nonatomic) NSInteger defense;
@property (readonly,nonatomic) float treasureDropRate;
@property (readonly,nonatomic) NSInteger encounterWeight;
@property (readonly,nonatomic) NSDictionary *mapable;
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(instancetype)initEmptyWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(void)saveToFile;
-(BOOL)isValid;
-(void)reload;
@end

NS_ASSUME_NONNULL_END

