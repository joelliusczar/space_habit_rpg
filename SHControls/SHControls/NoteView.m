//
//  NoteViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NoteView.h"
#import <SHCommon/NSObject+Helper.h>
#import "SHEventInfo.h"


@interface NoteView ()
@end

@implementation NoteView


-(void)textViewDidChange:(UITextView *)textView{
    wrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = [[SHEventInfo alloc]init:nil withSenders:textView,self,nil];
        [self.delegate textDidChange:e];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
