//
//  UIView+Helpers.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "UIView+Helpers.h"

@implementation UIView (Helpers)

-(void)resizeHeightByOffset:(CGFloat)offset{
    CGRect frame = self.frame;
    frame.size.height += offset;
    self.frame = frame;
}

-(void)resizeBoundsHeightByOffset:(CGFloat)change{
    CGRect bounds = self.bounds;
    bounds.size.height += change;
    self.bounds = bounds;
}


-(void)setupBorder:(UIRectEdge)edges
     withThickness:(CGFloat)thickness
          andColor:(UIColor *)color{
    CALayer *layer = self.layer;
    if(edges&UIRectEdgeTop){
        CALayer *borderLayer = [[CALayer alloc] init];
        borderLayer.backgroundColor = color.CGColor;
        borderLayer.frame = CGRectMake(0,0,self.frame.size.width,thickness);
        [layer addSublayer:borderLayer];
    }
    if(edges&UIRectEdgeLeft){
        CALayer *borderLayer = [[CALayer alloc] init];
        borderLayer.backgroundColor = color.CGColor;
        borderLayer.frame = CGRectMake(0,0,thickness,self.frame.size.height);
        [layer addSublayer:borderLayer];
    }
    if(edges&UIRectEdgeRight){
        CALayer *borderLayer = [[CALayer alloc] init];
        borderLayer.backgroundColor = color.CGColor;
        CGFloat offsetX = self.frame.size.width -  thickness;
        borderLayer.frame = CGRectMake(offsetX,0,thickness,self.frame.size.height);
        [layer addSublayer:borderLayer];
    }
    if(edges&UIRectEdgeBottom){
        CALayer *borderLayer = [[CALayer alloc] init];
        borderLayer.backgroundColor = color.CGColor;
        CGFloat offsetY = self.frame.size.height -thickness;
        borderLayer.frame = CGRectMake(0,offsetY,self.frame.size.width,thickness);
        [layer addSublayer:borderLayer];
    }
    
}


-(void)resizeFrame:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


@end
