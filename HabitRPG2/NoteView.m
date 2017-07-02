//
//  NoteViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NoteView.h"


@interface NoteView ()
@end

@implementation NoteView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,258,157);
}


-(void)textViewDidChange:(UITextView *)textView{
    if(self.delegate){
        [self.delegate textDidChange:textView];
    }
}

@end
