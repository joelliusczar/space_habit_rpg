//
//	NoteViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHNoteView.h"
#import <SHCommon/NSObject+Helper.h>
#import "SHEventInfo.h"


@interface SHNoteView ()
@end

@implementation SHNoteView


-(instancetype)init{
	NSBundle *bundle = [NSBundle bundleForClass:SHNoteView.class];
	if(self = [self initWithNibName:@"SHNoteView" bundle:bundle]){}
	return self;
}


-(void)textViewDidChange:(UITextView *)textView{
	SHEventInfo *e = [[SHEventInfo alloc]init:nil withSenders:textView,self,nil];
	[self.delegate textDidChange:e];
}

@end
