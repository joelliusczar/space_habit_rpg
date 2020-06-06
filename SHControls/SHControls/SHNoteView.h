//
//  NoteViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHNotesViewDelegateProtocol.h"
#import "SHViewController.h"
@import UIKit;

@protocol SHNotesViewDelegateProtocol;

@interface SHNoteView : SHViewController<UITextViewDelegate>
@property (weak,nonatomic) IBOutlet UITextView *noteBox;
@property (weak,nonatomic) id<SHNotesViewDelegateProtocol> delegate;
@end
