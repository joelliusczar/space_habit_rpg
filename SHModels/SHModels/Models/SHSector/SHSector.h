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

@interface SHSector : NSManagedObject<SHStoryItemProtocol,SHMappableProtocol>
@property (class,strong,nonatomic) SHSectorInfoDictionary* sectorInfo;
-(void)copyFrom:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END

#import "SHSector+CoreDataProperties.h"
