//
//  main.m
//  ObjCScriptRunner
//
//  Created by Joel Pridgen on 7/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MassPrinter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [MassPrinter outputAllLocaleFormatStringsToFile];
    }
    return 0;
}
