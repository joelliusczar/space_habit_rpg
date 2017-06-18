//
//  rateSetterDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol rateSetterDelegate <NSObject>
-(void)rateValueChanged:(UIStepper *)sender passedEvent:(UIEvent *)e;
@end
