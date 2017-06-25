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

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView =
        [[NSBundle mainBundle]
         loadNibNamed:NSStringFromClass(self.class)
         owner:self options:nil][0];
        
        [self addSubview:_mainView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //it's pretty fucked up that I have to do it this way.
    self.mainView.noteBox.delegate = self.mainView;
}

-(void)textViewDidChange:(UITextView *)textView{
    if(self.delegate){
        [self.delegate textDidChange:textView];
    }
}

@end
