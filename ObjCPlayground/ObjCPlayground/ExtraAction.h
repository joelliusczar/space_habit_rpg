//
//  ExtraAction.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/2/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

void PrintSomeH(){
	NSLog(@"Inside the h statement");
}

//PrintSomeH();

@interface ExtraAction : NSObject
@property (assign,nonatomic) NSInteger x;
@end
