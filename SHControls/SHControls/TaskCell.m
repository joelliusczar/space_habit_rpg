//
//  SHTaskCell.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHTaskCell.h"
#import <SHCommon/NSObject+Helper.h>

@interface SHTaskCell()
@end

@implementation SHTaskCell

-(instancetype)initWithFrame:(CGRect)frame{
	if(self = [super initWithFrame:frame]){
		UIView *view = [self loadDefaultXib];
		[self.contentView addSubview:view];
	}
	return self;
}


-(UIView *)loadDefaultXib{
	return [self loadXib:NSStringFromClass(self.class)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}




@end
