//
//  NoteViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NoteView.h"
#import "NSObject+Helper.h"


@interface NoteView ()
@end

@implementation NoteView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,258,157);
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
    }
    return self;
}

-(void)textViewDidChange:(UITextView *)textView{
    if(self.delegate){
        [self.delegate textDidChange:textView];
    }
}

@end
