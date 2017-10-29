//
//  SHControlArray.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHControlKeep.h"
#import "NSMutableDictionary+Helper.h"

typedef ControlExtent* (^w_LazyLoadBlock)(SHControlKeep *);

@interface ControlDictionary ()
@property (strong,nonatomic) NSMutableDictionary *backendDict;
-(void)removeObjectForKey:(id)key;
-(void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;
@end

@implementation ControlDictionary

-(NSMutableDictionary *)backendDict{
    if(nil == _backendDict){
        _backendDict = [NSMutableDictionary dictionary];
    }
    return _backendDict;
}

-(id)objectForKeyedSubscript:(id)key{
    return self.backendDict[key];
}


-(void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    self.backendDict[key] = obj;
}


-(void)removeObjectForKey:(id)key{
    [self.backendDict removeObjectForKey:key];
}

@end


@implementation AssociatedResponderAndSet

-(instancetype)init{
    if(self = [super init]){
        _set = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

-(void)dealloc{
    _responder = nil;
    _set = nil;
}

@end

@interface ControlExtent()
@property (strong,nonatomic) id control;
@end

@implementation ControlExtent
@end


@interface SHControlKeep()
@property (strong,nonatomic) NSMutableArray<w_LazyLoadBlock> *lazyLoaders;
@property (strong,nonatomic) NSMutableArray<ControlExtent *> *controlBackend;
@property (strong,nonatomic) NSMutableDictionary<NSString *,AssociatedResponderAndSet *> *associations;
@end

@implementation SHControlKeep

-(NSMutableArray<w_LazyLoadBlock> *)lazyLoaders{
    if(nil == _lazyLoaders)
    {
        _lazyLoaders = [NSMutableArray<w_LazyLoadBlock> array];
    }
    return _lazyLoaders;
}


-(NSMutableArray<ControlExtent *> *)controlBackend{
    if(nil == _controlBackend)
    {
        _controlBackend = [NSMutableArray array];
    }
    return _controlBackend;
}


-(ControlDictionary *)specificLookup{
    if(nil == _specificLookup){
        _specificLookup = [[ControlDictionary alloc] init];
    }
    return _specificLookup;
}


-(NSMutableDictionary *)associations{
    if(nil == _associations)
    {
        _associations = [NSMutableDictionary dictionary];
    }
    return _associations;
}


-(NSMutableDictionary *)customProps{
    if(nil == _customProps)
    {
        _customProps = [NSMutableDictionary dictionary];
    }
    return _customProps;
}


-(NSUInteger)count{
    return self.lazyLoaders.count;
}


-(NSUInteger)associatedCount{
    return self.associations.count;
}


NSString* buildKey(SELPtr *sel,NSString *secondaryKey){
    return [NSString stringWithFormat:@"%@:%@",secondaryKey,NSStringFromSelector(sel.selector)];
}

w_LazyLoadBlock wrapLoaderBlock(LazyLoadBlock loaderBlock,NSUInteger idx){
    return ^ControlExtent *(SHControlKeep *keep){
        ControlExtent *controlExtent = [[ControlExtent alloc] init];
        controlExtent.control = loaderBlock(keep,controlExtent);
        NSCAssert(controlExtent != controlExtent.control,@"You should not try to return control extent.");
        NSCAssert(controlExtent.control != keep,@"You should not try to return keep");
        
        if(controlExtent.key){
            keep.specificLookup[controlExtent.key] = controlExtent.control;
        }
        return controlExtent;
    };
}

//returns the control
-(id)objectAtIndexedSubscript:(NSUInteger)idx{
    ControlExtent *controlExtent = self.controlBackend[idx];
    if(controlExtent.control != nil){
        return controlExtent.control;
    }
    controlExtent = self.lazyLoaders[idx](self); //any associations will happen in the provided block
    self.controlBackend[idx] = controlExtent;
    return controlExtent.control;
}


-(void)setObject:(id)loaderBlock atIndexedSubscript:(NSUInteger)idx{
    self.lazyLoaders[idx] = wrapLoaderBlock(loaderBlock,idx);
    ControlExtent *controlExtent = self.controlBackend[idx];
    if(controlExtent.key){
        [self.specificLookup removeObjectForKey:controlExtent.key];
    }
    self.controlBackend[idx] = [[ControlExtent alloc] init];
}


-(id)objectForKeyedSubscript:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    return self.associations[buildKey(key,secondaryKey)];
}


-(id)objectForKeyedSubscript:(SELPtr *)key{
    return [self objectForKeyedSubscript:key secondaryKey:@""];
}


//assign responder to control. control will do actions to responder
BOOL associateResponder(SEL selector,id control,id responder){
    typedef void (*setter)(id,SEL,id);
    if([control respondsToSelector:selector]){
        setter impl = (setter)[control methodForSelector:selector];
        impl(control,selector,responder);
        return true;
    }
    return false;
}


-(AssociatedResponderAndSet *)getOrCreateAssociationForKey:(NSString *)key{
    AssociatedResponderAndSet *association = self.associations[key];
    if(nil == association){
        association = [[AssociatedResponderAndSet alloc] init];
        self.associations[key] = association;
    }
    return association;
}


//call this from a loadedBlock to add a control to the set and wireup the responder recieving actions
//if it exists
-(BOOL)addControlToActionSet:(id)control withKey:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    AssociatedResponderAndSet *association = [self getOrCreateAssociationForKey:buildKey(key,secondaryKey)];
    [association.set addObject:control];
    
    return association.responder?associateResponder(key.selector,control,association.responder):false;
}

-(BOOL)addControlToActionSet:(id)control withKey:(SELPtr *)key{
    return [self addControlToActionSet:control withKey:key secondaryKey:@""];
}


//use this when setting something as a global delegate
-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    AssociatedResponderAndSet *association = [self getOrCreateAssociationForKey:buildKey(key,secondaryKey)];
    association.responder = obj;
    @autoreleasepool{
        
        for(id control in association.set){
            //assign our new responder to each control in the set associated with that selector
            associateResponder(key.selector,control,association.responder);
        }
    }
}


-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key{
    [self setObject:obj forKeyedSubscript:key secondaryKey:@""];
}


-(NSUInteger)indexOfObject:(id)object{
    return [self.controlBackend indexOfObject:object];
}

-(void)addLoaderBlock:(LazyLoadBlock)loaderBlock{
    [self.lazyLoaders addObject:wrapLoaderBlock(loaderBlock,self.lazyLoaders.count)];
    [self.controlBackend addObject:[[ControlExtent alloc] init]];
}



@end
