//
//  ExpNonNull.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ExpNonNull.h"

@implementation ExpNonNull


+(int)cNonNull:(House *)h{
    if(h){
        return 1;
    }
    return 0;
}


-(int)instanceNonNulls:(House *)h{
    if(h){
        return 2;
    }
    return -1;
}


+(House *)cRetNonNull{
    return nil;
}


-(House *)instanceRetNonNulls{
    return nil;
}

@end
