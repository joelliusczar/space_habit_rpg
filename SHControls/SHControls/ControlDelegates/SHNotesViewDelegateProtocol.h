//
//  SHNotesViewDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SHCommonDelegateProtocol.h"
#import "SHEventInfo.h"

@class SHNoteView;

@protocol SHNotesViewDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)textDidChange:(SHEventInfo *)eventInfo;
@end
