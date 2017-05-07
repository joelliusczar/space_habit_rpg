//
//  ZoneChoiceCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneChoiceCellController.h"
#import "ZoneDescriptionViewController.h"
#import "ViewHelper.h"
#import "CommonUtilities.h"

@interface ZoneChoiceCellController()
@property (nonatomic,weak) ZoneChoiceViewController *ownerZoneController;
@property (nonatomic,weak) Zone *model;
@property (nonatomic,weak) NSIndexPath *rowInfo;
@property (nonatomic,strong) UISwipeGestureRecognizer *swiper;
-(void)setupCell:(Zone *)model AndOwner:(ZoneChoiceViewController *)owner
          AndRow:(NSIndexPath *)rowInfo;
@end

@implementation ZoneChoiceCellController

@synthesize nameLbl = _nameLbl;
-(UILabel *)nameLbl{
    if(!_nameLbl){
        _nameLbl = [self.contentView viewWithTag:1];
    }
    return _nameLbl;
}

@synthesize lvlLbl = _lvlLbl;
-(UILabel *)lvlLbl{
    if(!_lvlLbl){
        _lvlLbl = [self.contentView viewWithTag:2];
    }
    return _lvlLbl;
}

@synthesize swiper = _swiper;
-(UISwipeGestureRecognizer *)swiper{
    if(!_swiper){
        _swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        _swiper.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swiper;
}

+(instancetype)getZoneChoiceCell:(UITableView *)tableView WithOwner:(ZoneChoiceViewController *)owner
    AndModel:(Zone *)model AndRow:(NSIndexPath *)rowInfo
{
    ZoneChoiceCellController *cell = [ZoneChoiceCellController getCell:tableView WithNibName:@"ZoneChoiceCell" AndParent:owner];
    [cell setupCell:model AndOwner:owner AndRow:rowInfo];
    return cell;
}

-(void)setupCell:(Zone *)model AndOwner:(ZoneChoiceViewController *)owner
          AndRow:(NSIndexPath *)rowInfo
{
    self.ownerZoneController = owner;
    self.model = model;
    self.nameLbl.text = self.model.fullName;
    self.lvlLbl.text = [NSString stringWithFormat:@"Lvl: %d",self.model.lvl];
    self.rowInfo = rowInfo;
    [self addGestureRecognizer:self.swiper];
    [CommonUtilities checkForAndApplyVisualChanges:self.contentView];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)swipe{
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        ZoneDescriptionViewController *descView = self.ownerZoneController.descViewController;
        [descView setDisplayItems:self.model];
        [ViewHelper pushViewToFront:descView OfParent:self.ownerZoneController];
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
