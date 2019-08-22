//
//	SHView.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/7/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHCommon/SHInterceptorProtocol.h>
#import "SHViewProtocol.h"
#import "SHViewEventsProtocol.h"

IB_DESIGNABLE
@interface SHView: UIView
@property (strong,nonatomic) UIView *mainView;
@property (weak,nonatomic) UIView *holderView;
@property (assign,nonatomic) IBOutlet id<SHViewEventsProtocol> eventDelegate;
-(instancetype)initEmpty;
-(void)changeBackgroundColorTo:(UIColor *)color;
-(UIView *)loadDefaultXib;
//abstract
-(void)setupCustomOptions;
//abstract
-(void)beginTap_action:(UITouch *)touch
	withEvent:(UIEvent *)event;
@end
