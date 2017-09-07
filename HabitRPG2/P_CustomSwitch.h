//
//  P_CustomSwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_CustomSwitch <NSObject>
@property (assign,nonatomic) IBInspectable BOOL isOn;
@property (nonatomic) NSInteger tag;
@property (strong,nonatomic) IBInspectable NSString *dayKey;
@end
