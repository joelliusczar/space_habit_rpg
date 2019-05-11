//
//  SHRangeRateItem.m
//  SHModels
//
//  Created by Joel Pridgen on 5/10/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRangeRateItem.h"

@implementation SHRangeRateItem


-(void)copyFromCStruct:(SHRateValueItem *)rvi{
  self.isDayActive = rvi->isDayActive;
  self.forrange = rvi->forrange;
  self.backrange = rvi->backrange;
}


-(void)copyIntoCStruct:(SHRateValueItem *)rvi{
  rvi->isDayActive = self.isDayActive;
  rvi->forrange = self.forrange;
  rvi->backrange = self.backrange;
}

@end
