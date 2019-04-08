//
//  InfoDictionary.h
//  SHModels
//
//  Created by Joel Pridgen on 10/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/P_ResourceUtility.h>

@interface InfoDictionary : NSObject
@property (strong,nonatomic) NSDictionary *treeDict;
@property (strong,nonatomic) NSMutableDictionary *flatDict;
@property (readonly,strong,nonatomic) NSString *pListKey;
@property (readonly,nonatomic) Class bundleClass;
@property (strong,nonatomic) NSObject<P_ResourceUtility> *resourceUtil;

-(instancetype)initWithPListKey:(NSString*)key AndBundleClass:(Class)bundleClass
AndResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil;

-(NSDictionary*)searchTreeForKey:(NSString*)key;
-(NSDictionary*)getInfo:(NSString*)key;
-(NSDictionary*)getInfo:(NSString *)key forGroup:(NSString*)groupKey;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
@end
