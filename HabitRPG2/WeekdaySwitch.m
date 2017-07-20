//
//  WeekdaySwitch.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/11/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "WeekdaySwitch.h"
#import "CommonUtilities.h"
#import "SHMath.h"

@interface WeekdaySwitch ()

@end

@implementation WeekdaySwitch

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        UIView *view = [self loadXib];
        [self addSubview:view];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        UIView *view = [self loadXib];
        [self addSubview:view];
    }
    return self;
}

-(UIView *)loadXib{
    return [[NSBundle bundleForClass:self.class]
            loadNibNamed:NSStringFromClass(self.class)
            owner:self options:nil][0];
}


-(void)setDayFlag:(NSInteger)dayFlag{
    NSAssert([SHMath isPowerOfTwo:dayFlag]&&dayFlag<=(1<<6),
             @"invalid value for dayFlag");
    _dayFlag = dayFlag;
}

-(BOOL)isOn{
    return self.btnSwitch.isOn;
}

-(void)setIsOn:(BOOL)isOn{
    self.btnSwitch.isOn = isOn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
