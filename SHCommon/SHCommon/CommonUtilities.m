//
//  CommonUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import "CommonUtilities.h"

uint randomUIntF(uint bound){
    return arc4random_uniform(bound);
}

uint (*randomUInt)(uint) = &randomUIntF;

CGFloat GetYStartUnderLabel(CGFloat height){
    return height *.10;
}

void reverse_UINT(NSUInteger * _Nonnull array,NSUInteger len){
    for(NSUInteger i = 0;i < len/2;i++){
        NSUInteger tmp = array[i];
        array[i] = array[len - i -1];
        array[len -i -1] = tmp;
    }
}

CGFloat getParentChildHeightOffset(CGRect parentFrame,CGRect childFrame){
  return CGRectGetHeight(childFrame) < CGRectGetHeight(parentFrame) ?
      CGRectGetHeight(parentFrame) - CGRectGetHeight(childFrame) : 0;
}

