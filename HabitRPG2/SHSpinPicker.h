//
//  SHSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;

@interface SHSpinPicker : UIViewController
<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak,nonatomic) IBOutlet UIPickerView *picker;
@end
