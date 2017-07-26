//
//  NSObject+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)
-(void)safeRemoveObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nonnull)keyPath context:(void *_Nullable)context{
    @try{
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
    @catch(NSException *ex){}
}


-(UIView *)loadXib:(NSString *)nibName{
    return [[NSBundle bundleForClass:self.class]
            loadNibNamed:nibName owner:self options:nil][0];
}
@end
