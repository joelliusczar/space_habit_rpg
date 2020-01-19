//
//  SHNotesViewDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHCommonDelegateProtocol.h"
#import "SHNoteView.h"
@import Foundation;
@import UIKit;

@class SHNoteView;

@protocol SHNotesViewDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)textDidChange:(SHNoteView *)sender;
@end
