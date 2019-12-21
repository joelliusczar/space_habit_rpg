//
//  SHHabitCell.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHControls/SHControls.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHHabitCell : SHTaskCell
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectID;
-(void)setupCell:(SHObjectIDWrapper *)objectID;
@end

NS_ASSUME_NONNULL_END
