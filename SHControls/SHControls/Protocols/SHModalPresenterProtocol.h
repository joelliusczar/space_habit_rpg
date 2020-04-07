//
//  SHModalPresenterProtocol.h
//  SHControls
//
//  Created by Joel Pridgen on 3/28/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SHModalPresenterProtocol <NSObject>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@end

NS_ASSUME_NONNULL_END
