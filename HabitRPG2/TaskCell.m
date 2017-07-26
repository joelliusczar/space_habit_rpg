//
//  TaskCell.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"


@interface TaskCell()
@end

@implementation TaskCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        UIView *view = [self loadXib];
        [self addSubview:view];
    }
    return self;
}


-(instancetype)init{
    if(self = [super init]){
        UIView *view = [self loadXib];
        [self addSubview:view];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UIView *)loadXib{
    return [[NSBundle bundleForClass:self.class]
            loadNibNamed:NSStringFromClass(self.class) owner:self options:nil][0];
}



@end
