//
//  SHSectorChoiceCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceCellController.h"
#import "SHSectorDescriptionViewController.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHCommonUtils.h>
#import <SHControls/UIView+Helpers.h>

@interface SHSectorChoiceCellController()
@property (nonatomic,weak) SHSectorChoiceViewController *parentSectorController;
@property (nonatomic,weak) SHSectorDTO *model;
@property (nonatomic,weak) NSIndexPath *rowInfo;
@property (nonatomic,strong) UISwipeGestureRecognizer *swiper;
@end

@implementation SHSectorChoiceCellController


-(UISwipeGestureRecognizer *)swiper{
    if(!_swiper){
        _swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        _swiper.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swiper;
}



+(instancetype)getSectorChoiceCell:(UITableView *)tableView WithParent:(SHSectorChoiceViewController *)parent
AndModel:(SHSectorDTO *)model AndRow:(NSIndexPath *)rowInfo
{
    SHSectorChoiceCellController *cell = [tableView
      dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
      cell = [[SHSectorChoiceCellController alloc] init];
    }
    [cell setupCell:model AndParent:parent AndRow:rowInfo];
    return cell;
}

-(void)setupCell:(SHSectorDTO *)model AndParent:(SHSectorChoiceViewController *)parent
          AndRow:(NSIndexPath *)rowInfo
{
    self.parentSectorController = parent;
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
        SHSectorDescriptionViewController *descView = self.parentSectorController.descViewController;
        [descView setDisplayItems:self.model];
        [self.parentSectorController arrangeAndPushChildVCToFront:descView];
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
