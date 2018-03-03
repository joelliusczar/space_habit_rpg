//
//  P_EditControlKeep;.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_EditControlKeep <NSObject>
@property (strong,nonatomic) NSOrderedSet<SHView *> *allControls;
@end
