//
//  EditingSaver.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@protocol EditingSaver <NSObject>
@required
@property UIView *view;
-(void)cancelEdit;
-(void)saveEdit;
-(BOOL)deleteModel;
@end
