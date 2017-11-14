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

@interface SHControlKeep()
@property (strong,nonatomic) NSMutableArray<w_LazyLoadBlock> *lazyLoaders;
@property (strong,nonatomic) NSMutableArray<ControlExtent *> *controlBackend;
@property (strong,nonatomic) NSMutableDictionary<id,NSNumber *> *indexLookup;
@property (strong,nonatomic) NSMutableDictionary<NSString *,AssociatedResponderAndSet *> *associations;
@property (strong,nonatomic) NSMutableSet<PairWrapper<SELPtr *,NSString *> *> *actionSetAdditionsQueue;
-(AssociatedResponderAndSet *)getOrCreateAssociationForKey:(NSString *)key;
-(BOOL)addControlToActionSet:(id)control withKey:(SELPtr *)key;
-(BOOL)addControlToActionSet:(id)control withKey:(SELPtr *)key secondaryKey:(NSString *)secondaryKey;
@end

@implementation ControlExtent

-(void)setIdx:(NSUInteger)idx{
    if(self.isReadOnlyMode){
        return;
    }
    _idx = idx;
}


-(void)setControl:(id)control{
    if(self.isReadOnlyMode){
        return;
    }
    _control = control;
}


-(void)setKey:(id<NSCopying>)key{
    if(self.isReadOnlyMode){
        return;
    }
    _key = key;
}


-(void)setIsReadOnlyMode:(BOOL)isReadOnlyMode{
    _isReadOnlyMode = isReadOnlyMode;
}

@end


void processControlsForActionSets(SHControlKeep *keep,id control){
    if(nil == keep.actionSetAdditionsQueue){
        return;
    }
    
    for (PairWrapper<SELPtr *,NSString *> *keyPair in keep.actionSetAdditionsQueue) {
        [keep addControlToActionSet:control withKey:keyPair.item secondaryKey:keyPair.item2];
    }
    keep.actionSetAdditionsQueue = nil;
}


w_LazyLoadBlock wrapLoaderBlock(LazyLoadBlock loaderBlock,NSUInteger idx,id<NSCopying> key){
    return ^ControlExtent *(SHControlKeep *keep){
        ControlExtent *controlExtent = [[ControlExtent alloc] init];
        controlExtent.isReadOnlyMode = NO;
        controlExtent.idx = idx;
        controlExtent.control = loaderBlock(keep,controlExtent);
        NSCAssert(controlExtent != controlExtent.control,@"You should not try to return control extent.");
        NSCAssert(controlExtent.control != keep,@"You should not try to return keep");
        if(key){
            controlExtent.key = key;
        }
        controlExtent.idx = idx; //incase the passed block tried to change this
        controlExtent.isReadOnlyMode = YES;
        if(controlExtent.key){
            keep.indexLookup[controlExtent.key] = @(idx);
        }
        processControlsForActionSets(keep,controlExtent.control);
        return controlExtent;
    };
}


NSString* buildKey(SELPtr *sel,NSString *secondaryKey){
    return [NSString stringWithFormat:@"%@:%@",secondaryKey,NSStringFromSelector(sel.selector)];
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



@implementation ControlDictionary

-(instancetype)init:(SHControlKeep *)owner{
    if(self = [self init]){
        _owner = owner;
    }
    return self;
}



-(id)objectForKeyedSubscript:(id)key{
    if(!self.owner.indexLookup[key]){
        return nil;
    }
    NSUInteger idx = self.owner.indexLookup[key].unsignedIntegerValue;
    return self.owner.controlList[idx];
}


-(void)setObject:(VarWrapper<LazyLoadBlock> *)obj forKeyedSubscript:(id<NSCopying>)key{
    if(self.owner.indexLookup[key]){
        NSUInteger idx = self.owner.indexLookup[key].unsignedIntegerValue;
        self.owner.controlList[idx] = [[VarWrapper<LazyLoadBlock> alloc] init:obj,nil];
    }
    else{
        [self.owner addLoaderBlock:obj.item withKey:key];
    }
}


-(void)removeObjectForKey:(id)key{
    if(!self.owner.indexLookup[key]){
        return;
    }
    NSUInteger idx = self.owner.indexLookup[key].unsignedIntegerValue;
    [self.owner.lazyLoaders removeObjectAtIndex:idx];
    [self.owner.controlBackend removeObjectAtIndex:idx];
    [self.owner.indexLookup removeObjectForKey:key];
}

@end



@implementation ControlList


-(instancetype)init:(SHControlKeep *)owner{
    if(self = [self init]){
        _owner = owner;
    }
    return self;
}


-(NSUInteger)count{
    return self.owner.lazyLoaders.count;
}


//returns the control
-(id)objectAtIndexedSubscript:(NSUInteger)idx{
    ControlExtent *controlExtent = self.owner.controlBackend[idx];
    if(controlExtent.control != nil){
        return controlExtent.control;
    }
    controlExtent = self.owner.lazyLoaders[idx](self.owner); //any associations will happen in the provided block
    self.owner.controlBackend[idx] = controlExtent;
    return controlExtent.control;
}


-(void)setObject:(VarWrapper<LazyLoadBlock> *)loaderBlock atIndexedSubscript:(NSUInteger)idx{
    id key = nil;
    key = [loaderBlock isKindOfClass:PairWrapper.class]?((PairWrapper *)loaderBlock).item2:nil;
    self.owner.lazyLoaders[idx] = wrapLoaderBlock(loaderBlock.item,idx,key);
    ControlExtent *controlExtent = self.owner.controlBackend[idx];
    if(controlExtent.key){
        [self.owner.indexLookup removeObjectForKey:controlExtent.key];
    }
    if(key){
        self.owner.indexLookup[key] = [NSNumber numberWithUnsignedInteger:idx];
    }
    self.owner.controlBackend[idx] = [[ControlExtent alloc] init];
}


-(void)setObject:(LazyLoadBlock)loaderBlock atIndexedSubscript:(NSUInteger)idx andKey:(id<NSCopying>)key{
    PairWrapper<LazyLoadBlock,id> *wrapper = [[PairWrapper<LazyLoadBlock,id> alloc] init:loaderBlock,key,nil];
    self[idx] = (VarWrapper<LazyLoadBlock> *)wrapper;
}


-(NSUInteger)indexOfObject:(id)object{
    return [self.owner.controlBackend indexOfObject:object];
}

@end


@implementation ResponderDictionary


-(instancetype)init:(SHControlKeep *)owner{
    if(self = [self init]){
        _owner = owner;
    }
    return self;
}

-(AssociatedResponderAndSet *)objectForKeyedSubscript:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    return self.owner.associations[buildKey(key,secondaryKey)];
}


-(AssociatedResponderAndSet *)objectForKeyedSubscript:(SELPtr *)key{
    return [self objectForKeyedSubscript:key secondaryKey:@""];
}


//use this when setting something as a global delegate
-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    AssociatedResponderAndSet *association = [self.owner getOrCreateAssociationForKey:buildKey(key,secondaryKey)];
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


-(NSMutableDictionary *)indexLookup{
    if(nil == _indexLookup){
        _indexLookup = [NSMutableDictionary dictionary];
    }
    return _indexLookup;
}


-(ControlDictionary *)controlLookup{
    if(nil == _controlLookup){
        _controlLookup = [[ControlDictionary alloc] init:self];
    }
    return _controlLookup;
}


-(ControlList *)controlList{
    if(nil == _controlList){
        _controlList = [[ControlList alloc] init:self];
    }
    return _controlList;
}


-(ResponderDictionary *)responderLookup{
    if(nil == _responderLookup){
        _responderLookup = [[ResponderDictionary alloc] init:self];
    }
    return _responderLookup;
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


-(NSUInteger)associatedCount{
    return self.associations.count;
}

-(AssociatedResponderAndSet *)getOrCreateAssociationForKey:(NSString *)key{
    AssociatedResponderAndSet *association = self.associations[key];
    if(nil == association){
        association = [[AssociatedResponderAndSet alloc] init];
        self.associations[key] = association;
    }
    return association;
}


-(void)addControlToActionSetWithKey:(SELPtr *)key{
    [self addControlToActionSetWithKey:key secondaryKey:@""];
}


-(void)addControlToActionSetWithKey:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    if(nil == self.actionSetAdditionsQueue){
        self.actionSetAdditionsQueue = [NSMutableSet set];
    }
    /*This is slightly buggy because I need to override hash on PairWrapper*/
    PairWrapper *pw = [[PairWrapper alloc] init:key,secondaryKey,nil];
    NSAssert(![self.actionSetAdditionsQueue containsObject:pw],@"You're trying to add duplicate keys. Stop that!");
    [self.actionSetAdditionsQueue addObject:pw];
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


-(void)addLoaderBlock:(LazyLoadBlock)loaderBlock{
    [self addLoaderBlock:loaderBlock withKey:nil];
}


-(void)addLoaderBlock:(LazyLoadBlock)loaderBlock withKey:(id<NSCopying>)key{
    if(key){
        self.indexLookup[key] = [NSNumber numberWithUnsignedInteger:self.lazyLoaders.count];
    }
    [self.lazyLoaders addObject:wrapLoaderBlock(loaderBlock,self.lazyLoaders.count,key)];
    [self.controlBackend addObject:[[ControlExtent alloc] init]];
}

@end
