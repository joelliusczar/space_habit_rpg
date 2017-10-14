//
//  SHControlArray.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHControlKeep.h"
#import "NSMutableDictionary+Helper.h"


@interface AssociatedObjectAndSet: NSObject
@property (strong,nonatomic) id object;
@property (strong,nonatomic) NSHashTable *set; //strong references are maintained elsewhere
@end

@implementation AssociatedObjectAndSet
-(instancetype)init{
    if(self = [super init]){
        _set = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

-(void)dealloc{
    _object = nil;
    _set = nil;
}
@end

@interface SHControlKeep()
@property (strong,nonatomic) NSMutableArray<LazyLoadBlock> *lazyLoaders;
@property (strong,nonatomic) NSMutableArray *controlBackend;
@property (strong,nonatomic) NSMutableDictionary *associations;
@end

@implementation SHControlKeep

-(NSMutableArray<LazyLoadBlock> *)lazyLoaders{
    return _lazyLoaders?_lazyLoaders:[NSMutableArray<LazyLoadBlock> array];
}


-(NSMutableArray *)controlBackend{
    return _controlBackend?_controlBackend:[NSMutableArray array];
}


-(NSMutableDictionary *)associations{
    return _associations?_associations:[NSMutableDictionary dictionary];
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


//returns the subject
-(id)objectAtIndexedSubscript:(NSUInteger)idx{
    id control = self.controlBackend[idx];
    if(control != [NSNull null]){
        return control;
    }
    control = self.lazyLoaders[idx](self); //any associations will happen in the provided block
    self.controlBackend[idx] = control?control:[NSNull null];
    return control;
}


-(void)setObject:(id)loaderBlock atIndexedSubscript:(NSUInteger)idx{
    self.lazyLoaders[idx] = loaderBlock;
    self.controlBackend[idx] = [NSNull null];
}


-(id)objectForKeyedSubscript:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    return self.associations[buildKey(key,secondaryKey)];
}


-(id)objectForKeyedSubscript:(SELPtr *)key{
    return [self objectForKeyedSubscript:key secondaryKey:@""];
}


//assign object to subject. subject will do actions to object
BOOL associateObject(SEL selector,id subject,id object){
    typedef void (*setter)(id,SEL,id);
    if([subject respondsToSelector:selector]){
        setter impl = (setter)[subject methodForSelector:selector];
        impl(subject,selector,object);
        return true;
    }
    return false;
}


-(AssociatedObjectAndSet *)getOrCreateAssociationForKey:(NSString *)key{
    AssociatedObjectAndSet *association = self.associations[key];
    if(nil == association){
        association = [[AssociatedObjectAndSet alloc] init];
        self.associations[key] = association;
    }
    return association;
}


//call this from a loadedBlock to add a subject to the set and wireup the object recieving actions
//if it exists
-(BOOL)addSubjectToActionSet:(id)subject withKey:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    AssociatedObjectAndSet *association = [self getOrCreateAssociationForKey:buildKey(key,secondaryKey)];
    [association.set addObject:subject];
    
    return association.object?associateObject(key.selector,subject,association.object):false;
}

-(BOOL)addSubjectToActionSet:(id)subject withKey:(SELPtr *)key{
    return [self addSubjectToActionSet:subject withKey:key secondaryKey:@""];
}


//use this when setting something as a global delegate
-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key secondaryKey:(NSString *)secondaryKey{
    AssociatedObjectAndSet *association = [self getOrCreateAssociationForKey:buildKey(key,secondaryKey)];
    association.object = obj;
    @autoreleasepool{
        
        for(id subject in association.set){
            //assign our new object to each subject in the set associated with that selector
            associateObject(key.selector,subject,association.object);
        }
    }
}

-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key{
    [self setObject:obj forKeyedSubscript:key secondaryKey:@""];
}


-(void)addLoaderBlock:(LazyLoadBlock)loaderBlock{
    [self.lazyLoaders addObject:loaderBlock];
    [self.controlBackend addObject:[NSNull null]];
}



@end
