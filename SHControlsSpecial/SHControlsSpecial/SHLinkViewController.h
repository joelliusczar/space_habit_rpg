//
//	SHLinkViewController.h
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 8/3/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHControls;
@import SHData;

NS_ASSUME_NONNULL_BEGIN

@interface SHLinkViewController : UIViewController<SHViewEventsProtocol>
@property (weak, nonatomic) IBOutlet UILabel *primaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak,nonatomic) UIViewController *editorContainer;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
-(void)setupWithContext:(NSManagedObjectContext *)context
	andObjectID:(SHObjectIDWrapper*)objectIDWrapper;
-(void)openNextScreen;
@end

NS_ASSUME_NONNULL_END
