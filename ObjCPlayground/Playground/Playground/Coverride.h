//
//  Coverride.h
//  Playground
//
//  Created by Joel Pridgen on 3/3/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

void outsideFunc(void);
void outsideNC(void);

@interface Coverride : NSObject

void insideFunc(void);
void insideNC(void);
-(void)callsItAll;

@end
