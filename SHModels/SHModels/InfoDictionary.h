//
//  InfoDictionary.h
//  SHModels
//
//  Created by Joel Pridgen on 10/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoDictionary : NSObject
@property (strong,nonatomic) NSDictionary *treeDict;
@property (strong,nonatomic) NSMutableDictionary *flatDict;
@property (strong,nonatomic) NSString *pListKey;
@property (nonatomic) Class bundleClass;
-(instancetype)initWithPListKey:(NSString*)key;
@end
