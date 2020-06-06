//
//	NoteViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHNoteView.h"


@interface SHNoteView ()
@end

@implementation SHNoteView


-(instancetype)init{
	NSBundle *bundle = [NSBundle bundleForClass:SHNoteView.class];
	if(self = [self initWithNibName:@"SHNoteView" bundle:bundle]){}
	return self;
}


-(void)textViewDidChange:(UITextView *)sender {
	(void)sender;
	[self.delegate textDidChange:self];
}

@end
