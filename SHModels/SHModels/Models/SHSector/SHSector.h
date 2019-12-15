//
//  SHSector.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSectorInfoDictionary.h"
#import "SHStoryItemProtocol.h"
@import Foundation;
@import CoreData;
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHSector : NSObject<SHStoryItemProtocol,SHMappableProtocol>
@property (class,strong,nonatomic) SHSectorInfoDictionary* sectorInfo;
@property (strong, nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (assign, nonatomic) NSInteger lvl;
@property (assign, nonatomic) NSInteger maxMonsters;
@property (assign, nonatomic) NSInteger monstersKilled;
@property (strong, nonatomic) NSString* suffix;
@property (strong, nonatomic) NSString* sectorKey;
@property (readonly,nonatomic) NSDictionary *mapable;
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(instancetype)initEmptyWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(instancetype)initWithDictionary:(NSMutableDictionary *)dict
	withResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(void)saveToFile;
-(BOOL)isValid;
-(void)reload;
@end

NS_ASSUME_NONNULL_END

