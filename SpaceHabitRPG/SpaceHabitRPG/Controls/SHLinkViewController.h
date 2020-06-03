//
//	SHLinkViewController.h
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 8/3/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHControls;
@import SHUtils_C;

NS_ASSUME_NONNULL_BEGIN

@interface SHLinkViewController : SHViewController
@property (weak, nonatomic) IBOutlet UILabel *primaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) SHViewController *editorContainer;
@property (assign, nonatomic) struct SHSerialQueue *queue;

@property (strong, nonatomic) IBOutlet UIImageView *navImageView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
-(void)openNextScreen;
-(void)finishSetup;
@end

NS_ASSUME_NONNULL_END
