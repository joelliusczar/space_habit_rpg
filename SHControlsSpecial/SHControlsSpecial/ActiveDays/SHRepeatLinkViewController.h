//
//  SHRepeatLinkViewController.h
//  SHControlsSpecial
//
//  Created by Joel Pridgen on 6/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHData/SHObjectIDWrapper.h>
#import <SHModels/SHDailyActiveDays.h>
#import <SHControls/SHView.h>
#import <SHControls/SHViewEventsProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHRepeatLinkViewController : UIViewController<SHViewEventsProtocol>
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
@property (weak,nonatomic) UIViewController *editorContainer;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
-(void)setupWithContext:(NSManagedObjectContext *)context
  andObjectID:(SHObjectIDWrapper*)objectIDWrapper;
@end

NS_ASSUME_NONNULL_END
