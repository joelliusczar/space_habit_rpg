//
//  SHDayOption.h
//  SHControlsSpecial
//
//  Created by Joel Pridgen on 6/30/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHControls/SHControls.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface SHDayOption : SHSwitch
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end

NS_ASSUME_NONNULL_END
