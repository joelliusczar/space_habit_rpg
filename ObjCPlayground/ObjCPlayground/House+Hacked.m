//
//  House+Hacked.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/11/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "House+Hacked.h"
#import <objc/runtime.h>

@implementation House (Hacked)

-(int)stuffedInt{
    Ivar ivar = class_getInstanceVariable(object_getClass(self),"stuffedInt");
    if(!ivar) return 0;
    return *((int *)((__bridge void *)self + ivar_getOffset(ivar)));
}

-(void)setStuffedInt:(int)stuffedInt{
    Ivar ivar = class_getInstanceVariable(object_getClass(self),"stuffedInt");
    if(!ivar) return;
    *((int *)((__bridge void *)self + ivar_getOffset(ivar))) = stuffedInt;
}

+(Class)getHackedClassDef{
    static Class hackedHouse = nil;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken,^(){
        hackedHouse = objc_allocateClassPair(House.class,"HackedHouse",0);
        class_addIvar(House.class,"stuffedInt",sizeof(int),rint(log2(sizeof(int))),@encode(int));
        objc_registerClassPair(hackedHouse);
    });
    return hackedHouse;
}

+(void)hackTheHouse{
    Method ogMethod = class_getClassMethod(House.class,@selector(alloc));
    (void)ogMethod;
}



@end
