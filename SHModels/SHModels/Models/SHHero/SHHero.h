//
//  SHHero.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHHero : NSObject
@property (readonly,nonatomic) NSDictionary *mapable;
@property (assign, nonatomic) NSInteger gold;
@property (assign, nonatomic) NSInteger lvl;
@property (assign, nonatomic) NSInteger maxHp;
@property (assign, nonatomic) NSInteger maxXp;
@property (assign, nonatomic) NSInteger nowHp;
@property (assign, nonatomic) NSInteger nowXp;
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(void)saveToFile;
@end

NS_ASSUME_NONNULL_END

