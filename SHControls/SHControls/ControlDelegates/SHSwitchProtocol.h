//
//  SHCustomSwitchProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SHSwitchProtocol <NSObject>
@property (assign,nonatomic) IBInspectable BOOL isOn;
@property (nonatomic) NSInteger tag;
@end
