//
//  SHInfoDictionary.h
//  SHModels
//
//  Created by Joel Pridgen on 10/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHCommon;

@interface SHInfoDictionary : NSObject
@property (strong,nonatomic) NSDictionary *treeDict;
@property (strong,nonatomic) NSMutableDictionary *flatDict;
@property (readonly,strong,nonatomic) NSString *pListKey;
@property (readonly,nonatomic) Class bundleClass;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;

-(instancetype)initWithPListKey:(NSString*)key AndBundleClass:(Class)bundleClass
AndResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;

-(NSDictionary*)searchTreeForKey:(NSString*)key;
-(NSDictionary*)getInfo:(NSString*)key;
-(NSDictionary*)getInfo:(NSString *)key forGroup:(NSString*)groupKey;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
@end
