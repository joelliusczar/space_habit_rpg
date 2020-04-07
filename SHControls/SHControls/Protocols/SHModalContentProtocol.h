//
//  SHModalContentProtocol.h
//  SHControls
//
//  Created by Joel Pridgen on 3/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHViewController.h"
#import "SHModalPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SHModalContentProtocol <NSObject>
@property (weak, nonatomic) SHViewController<SHModalPresenterProtocol> *modalContentPresenter;
@end

NS_ASSUME_NONNULL_END
