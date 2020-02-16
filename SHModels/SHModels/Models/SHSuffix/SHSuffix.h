//
//  SHSuffix.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHSuffix : NSObject
@property (strong, nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(NSInteger)getAndIncrementCountForSector:(NSString*)sectorName;
-(void)saveToFile;
@end

NS_ASSUME_NONNULL_END

