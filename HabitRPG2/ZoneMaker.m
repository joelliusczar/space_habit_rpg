//
//  ZoneMaker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneMaker.h"
#import "constants.h"
#import "ZoneDescriptions.h"
#import "ZoneHelper.h"
#import "stdlib.h"
#import "CommonUtilities.h"
#import "DataInfo+CoreDataClass.h"
#import "Suffix+CoreDataClass.h"


@interface ZoneMaker()
@property (nonatomic,weak) NSObject<P_CoreData> *dataController;
@property (nonatomic,strong) CommonUtilities *util;
@end

@implementation ZoneMaker

@synthesize util = _util;
-(CommonUtilities *)util{
    if(_util == nil){
        _util = [[CommonUtilities alloc] init];
    }
    return _util;
}

-(instancetype)initWithDataController:(NSObject<P_CoreData>*)dataController{
    if(self = [self init]){
        self.dataController = dataController;
    }
    return self;
}

+(instancetype)constructWithDataController:(NSObject<P_CoreData>*)dataController{
    return [[ZoneMaker alloc] initWithDataController:dataController];
}



@end


