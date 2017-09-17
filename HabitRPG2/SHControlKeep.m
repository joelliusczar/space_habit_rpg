//
//  SHControlArray.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHControlKeep.h"

@interface AssociatedObjectAndSet: NSObject
@property (strong,nonatomic) id object;
@property (strong,nonatomic) NSMutableSet *set;
+(instancetype)newWithSet:(NSMutableSet *)set;
@end

@implementation AssociatedObjectAndSet
+(instancetype)newWithSet:(NSMutableSet *)set{
    AssociatedObjectAndSet *instance = [[AssociatedObjectAndSet alloc] init];
    instance.set = set;
    return instance;
}
@end

@interface SHControlKeep()
@property (strong,nonatomic) NSMutableArray<LazyLoadBlock> *lazyLoaders;
@property (strong,nonatomic) NSMutableArray *controlBackend;
@property (strong,nonatomic) NSMutableDictionary *associations;
@end

@implementation SHControlKeep

-(NSMutableArray<LazyLoadBlock> *)lazyLoaders{
    if(nil == _lazyLoaders){
        _lazyLoaders = [NSMutableArray array];
    }
    return _lazyLoaders;
}


-(NSMutableArray *)controlBackend{
    if(nil == _controlBackend){
        _controlBackend = [NSMutableArray array];
    }
    return _controlBackend;
}


-(NSMutableDictionary *)associations{
    if(nil == _associations){
        _associations = [NSMutableDictionary dictionary];
    }
    return _associations;
}


-(NSUInteger)count{
    return self.lazyLoaders.count;
}


//returns the subject
-(id)objectAtIndexedSubscript:(NSUInteger)idx{
    id control = self.controlBackend[idx];
    if(control != [NSNull null]){
        return control;
    }
    control = self.lazyLoaders[idx](self);
    self.controlBackend[idx] = control?control:[NSNull null];
    return control;
}


-(id)objectForKeyedSubscript:(SELPtr *)key{
    
    return self.associations[NSStringFromSelector(key.selector)];
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


-(AssociatedObjectAndSet *)getOrCreateAssociationForKey:(SELPtr *)key{
    AssociatedObjectAndSet *association = self.associations[NSStringFromSelector(key.selector)];
    if(nil == association){
        association = [AssociatedObjectAndSet
                       newWithSet:[NSMutableSet set]];
        self.associations[NSStringFromSelector(key.selector)] = association;
    }
    return association;
}


//call this from a loadedBlock to add a subject to the set and wireup the object recieving actions
//if it exists
-(BOOL)addSubjectToActionSet:(id)subject withKey:(SELPtr *)key{
    AssociatedObjectAndSet *association = [self getOrCreateAssociationForKey:key];
    [association.set addObject:subject];
    return association.object?associateObject(key.selector,subject,association.object):false;
}


//use this when setting something as a global delegate
-(void)setObject:(id)obj forKeyedSubscript:(SELPtr *)key{
    AssociatedObjectAndSet *association = [self getOrCreateAssociationForKey:key];
    association.object = obj;
    for(id subject in association.set){
        //assign our new object to each subject in the set associated with that selector
        associateObject(key.selector,subject,association.object);
    }
    
}


-(void)addLoaderBlock:(LazyLoadBlock)loaderBlock{
    [self.lazyLoaders addObject:loaderBlock];
    [self.controlBackend addObject:[NSNull null]];
}



@end
