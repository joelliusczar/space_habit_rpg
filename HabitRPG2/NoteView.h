//
//  NoteViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_NotesViewDelegate.h"
#import "P_EditScreenControl.h"

@interface NoteView : UIView <UITextViewDelegate, P_EditScreenControl>
@property (weak,nonatomic) IBOutlet NoteView *mainView;
@property (weak,nonatomic) IBOutlet UITextView *noteBox;
@property (weak,nonatomic) id<P_NotesViewDelegate> delegate;
@end
