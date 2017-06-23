//
//  DailyEditControlKeep.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/19/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyEditControlKeep.h"

@interface DailyEditControlKeep()
@property (assign,nonatomic) id<P_DailyEditCompound> delegate;
@end

@implementation DailyEditControlKeep

@synthesize delegate = _delegate;

@synthesize noteView = _noteView;
-(NoteView *)noteView{
    if(nil==_noteView){
        _noteView = [[NoteView alloc] initWithFrame:NoteView.naturalFrame];
        if(self.delegate){
            _noteView.delegate = self.delegate;
        }
    }
    return _noteView;
}

@synthesize activeDaysPicker = _activeDaysPicker;
-(ActiveDaysPicker *)activeDaysPicker{
    if(nil==_activeDaysPicker){
        _activeDaysPicker = [[ActiveDaysPicker alloc] initWithFrame:ActiveDaysPicker.naturalFrame];
        if(self.delegate){
            _activeDaysPicker.delegate = self.delegate;
        }
    }
    return _activeDaysPicker;
}

@synthesize rateSetterView = _rateSetterView;
-(RateSetterView *)rateSetterView{
    if(nil==_rateSetterView){
        _rateSetterView = [[RateSetterView alloc] initWithFrame:RateSetterView.naturalFrame];
        _rateSetterView.delegate = self.delegate;
    }
    return _rateSetterView;
}

@synthesize importanceSliders = _importanceSliders;
-(ImportanceSliderView *)importanceSliders{
    if(nil==_importanceSliders){
        _importanceSliders = [[ImportanceSliderView alloc] initWithFrame:ImportanceSliderView.naturalFrame];
        _importanceSliders.delegate = self.delegate;
    }
    return _importanceSliders;
}


@synthesize allControls = _allControls;
-(NSArray<UIView<P_EditScreenControl> *> *)allControls{
    return [NSArray arrayWithObjects:
            self.noteView
            ,self.activeDaysPicker
            ,self.rateSetterView
            ,self.importanceSliders
            ,nil];
}

-(instancetype)initWithDelegate:(id<P_DailyEditCompound>)delegate{
    if(self = [super init]){
        _delegate = delegate;
    }
    return self;
}

@end
