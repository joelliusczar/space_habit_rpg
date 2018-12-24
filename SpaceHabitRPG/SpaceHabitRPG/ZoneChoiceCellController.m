//
//  ZoneChoiceCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneChoiceCellController.h"
#import "ZoneDescriptionViewController.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/CommonUtilities.h>
#import <SHControls/UIView+Helpers.h>

@interface ZoneChoiceCellController()
@property (nonatomic,weak) ZoneChoiceViewController *parentZoneController;
@property (nonatomic,weak) Zone *model;
@property (nonatomic,weak) NSIndexPath *rowInfo;
@property (nonatomic,strong) UISwipeGestureRecognizer *swiper;
@end

@implementation ZoneChoiceCellController


-(UISwipeGestureRecognizer *)swiper{
    if(!_swiper){
        _swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        _swiper.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swiper;
}



+(instancetype)getZoneChoiceCell:(UITableView *)tableView WithParent:(ZoneChoiceViewController *)parent
AndModel:(Zone *)model AndRow:(NSIndexPath *)rowInfo
{
    ZoneChoiceCellController *cell = [tableView
      dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
      cell = [[ZoneChoiceCellController alloc] init];
    }
    [cell setupCell:model AndParent:parent AndRow:rowInfo];
    return cell;
}

-(void)setupCell:(Zone *)model AndParent:(ZoneChoiceViewController *)parent
          AndRow:(NSIndexPath *)rowInfo
{
    self.parentZoneController = parent;
    self.model = model;
    self.nameLbl.text = self.model.fullName;
    self.lvlLbl.text = [NSString stringWithFormat:@"Lvl: %d",self.model.lvl];
    self.rowInfo = rowInfo;
    [self addGestureRecognizer:self.swiper];
    [self.contentView checkForAndApplyVisualChanges];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)swipe{
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        ZoneDescriptionViewController *descView = self.parentZoneController.descViewController;
        [descView setDisplayItems:self.model];
        [self.parentZoneController arrangeAndPushChildVCToFront:descView];
    }
    else{
        NSLog(@"%@",@"wrong");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
