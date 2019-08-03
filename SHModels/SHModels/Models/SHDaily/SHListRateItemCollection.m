//
//  SHListRateItemCollection.m
//  SHModels
//
//  Created by Joel Pridgen on 5/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHListRateItemCollection.h"

@interface SHListRateItemCollection ()
@property (strong,nonatomic) NSMutableArray<SHListRateItem*> *activeDays;
@end

@implementation SHListRateItemCollection


-(instancetype)initWithActiveDays:(NSMutableArray<SHListRateItem*>*)activeDays{
  if(self == [super init]){
    _activeDays = activeDays;
  }
  return self;
}


-(NSUInteger)count{
  return self.activeDays.count;
}


-(NSUInteger)addRateItem:(SHListRateItem*)rateItem{
  if(self.touchCallback) self.touchCallback();
  NSUInteger idx = [self.activeDays findPlaceFor:rateItem
    whereFirstFits:^BOOL(SHListRateItem *a,SHListRateItem *b){
      BOOL minorCriteria = a.majorOrdinal == b.majorOrdinal && a.minorOrdinal >= b.minorOrdinal;
      return a.majorOrdinal > b.majorOrdinal || minorCriteria;
    }];
  if(idx == self.activeDays.count){
    [self.activeDays addObject:rateItem];
    return idx;
  }
  if(![rateItem isEqual: self.activeDays[idx]]){
    [self.activeDays insertObject:rateItem atIndex:idx];
    return idx;
  }
  return -1;
}


-(void)removeRateItemAtIndex:(NSUInteger)index{
  if(self.touchCallback){
    self.touchCallback();
  }
  [self.activeDays removeObjectAtIndex:index];
}


-(SHListRateItem*)objectAtIndexedSubscript:(NSUInteger)idx{
  SHListRateItem *rateItem = self.activeDays[idx];
  rateItem.touchCallback = self.touchCallback;
  return rateItem;
}

-(NSMutableArray*)mapItemsTo_f:(id  _Nonnull (*)(SHListRateItem *, NSUInteger))mapper{
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.activeDays.count];
  NSUInteger idx = 0;
  for (id obj in self.activeDays) {
    [result addObject:mapper(obj,idx)];
    idx++;
  }
  return result;
}

@end
