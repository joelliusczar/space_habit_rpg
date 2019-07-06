//
//  SHViewEventsProtocol.h
//  SHControls
//
//  Created by Joel Pridgen on 6/23/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHView.h"

@class SHView;

NS_ASSUME_NONNULL_BEGIN

@protocol SHViewEventsProtocol <NSObject>
@optional
-(void)onBeginTap_action:(SHView *)sender withEvent:(UIEvent*)event;
@end

NS_ASSUME_NONNULL_END
