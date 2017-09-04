//
//  SHEventInfo.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#define eventInfoCopy [[SHEventInfo alloc] init:event withSenders:sender,self,nil]

@interface SHEventInfo : NSObject
@property (readonly,nonatomic) NSTimeInterval timestamp;
@property (readonly,nonatomic) NSMutableOrderedSet *senderStack;
@property (readonly,nonatomic) UIEvent *wrappedEvent;
-(instancetype)init:(UIEvent *)event withSenders:(id)senders, ... NS_REQUIRES_NIL_TERMINATION;
@end
