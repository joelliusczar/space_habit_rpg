//
//  Experiments+Bravo.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Experiments+Bravo.h"

@implementation Experiments (Bravo)

-(void)bravoMethod{
    NSLog(@"%@",@"Bravo!");
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
 change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
  (void)object;
  (void)change;
  (void)context;
  if([keyPath isEqualToString:@"stupidNum"]){
      NSLog(@"%@",@"stupid num event");
  }
}


-(void)addObservo{
    [self addObserver:self forKeyPath:@"stupidNum" options:NSKeyValueObservingOptionNew context:nil];
}

@end
