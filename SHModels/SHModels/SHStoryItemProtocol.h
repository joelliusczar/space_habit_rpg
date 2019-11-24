//
//  SHStoryItemProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@protocol SHStoryItemProtocol <NSObject>
@property (readonly,nonatomic) NSString *fullName;
@property (readonly,nonatomic) NSString *synopsis;
@property (readonly,nonatomic) NSString *headline;
@end
