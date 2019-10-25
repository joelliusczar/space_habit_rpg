//
//	ReminderListContainer.h
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import UIKit;
@import SHData;

NS_ASSUME_NONNULL_BEGIN

@interface SHReminderListContainer : UIViewController
@property (weak,nonatomic) IBOutlet UIView *container;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
-(void)setupWithContext:(NSManagedObjectContext *)context
	andObjectID:(SHObjectIDWrapper*)objectIDWrapper;
@end

NS_ASSUME_NONNULL_END
