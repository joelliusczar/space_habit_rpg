//
//	ReadOonly.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ReadOonly : NSObject
@property (readonly,assign,nonatomic) NSInteger rudy;
@end

void setRoody(NSInteger num,ReadOonly *ro);
