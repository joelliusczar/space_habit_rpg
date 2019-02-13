//
//  SingletonCluster+App.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 3/1/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SingletonCluster+App.h"

@implementation SingletonCluster (App)


-(int)gameState{
    return SharedGlobal.userData.theDataInfo.gameState;
}


@end
