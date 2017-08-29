//
//  P_NotesViewDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "P_CommonDelegate.h"

@class NoteView;

@protocol P_NotesViewDelegate <NSObject,P_CommonDelegate>
-(void)noteView:(NoteView *)noteView textDidChange:(UITextView *)textView;
@end
