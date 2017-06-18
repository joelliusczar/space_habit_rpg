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

-(instancetype)new{
    return [[NSBundle mainBundle] loadNibNamed:@"NoteView" owner:self options:nil][0];
}

-(void)textViewDidChange:(UITextView *)textView{
    if(self.delegate){
        [self.delegate textDidChange:textView];
    }
}

@end
