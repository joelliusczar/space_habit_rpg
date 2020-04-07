//
//	ParentMan.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@interface ParentMan : NSObject
@property (assign) NSInteger contrlNum;
@property (class, strong, nonatomic) NSString *name;
+(instancetype)newParentMan;
-(instancetype)initTwo;
-(void)writeOverPublic;
-(void)nothing;
@end

