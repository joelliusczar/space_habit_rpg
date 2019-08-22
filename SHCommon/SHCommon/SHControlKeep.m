//
//  SHControlArray.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHControlKeep.h"
#import "NSMutableDictionary+Helper.h"


typedef SHControlExtent* (^w_LazyLoadBlock)(SHControlKeep *);

@interface SHControlKeep()
@property (strong,nonatomic) NSMutableArray<w_LazyLoadBlock> *lazyLoaders;
@property (strong,nonatomic) NSMutableArray<SHControlExtent *> *controlBackend;
@property (strong,nonatomic) NSMutableDictionary<id,NSNumber *> *indexLookup;
@property (strong,nonatomic) NSMutableDictionary<id<NSCopying>,AssociatedResponderAndSet *> *associations;
@property (strong,nonatomic) NSMutableArray<SHPairWrapper<SHKeyToken *,id<NSCopying>> *> *tokenQueue;
-(AssociatedResponderAndSet *)getOrCreateAssociationForKey:(id<NSCopying>)key;
-(void)cleanupSetupBlocks:(SHControlExtent *)controlExtent;
@end

@implementation SHControlExtent

-(instancetype)copyExtent{
	SHControlExtent *copy = [[SHControlExtent alloc] init];
	copy.idx = self.idx;
	copy.key = self.key;
	copy.control = self.control;
	copy.blockTrackers = self.blockTrackers;
	return copy;
}


@end



w_LazyLoadBlock wrapLoaderBlock(SHLazyLoadBlock loaderBlock,NSUInteger idx,id<NSCopying,NSObject> key){
	return ^SHControlExtent *(SHControlKeep *keep){
		SHControlExtent *controlExtent = [[SHControlExtent alloc] init];
		controlExtent.idx = idx;
		SHControlExtent *copy = [controlExtent copyExtent];
		controlExtent.control = loaderBlock(keep,copy);
		NSCAssert(controlExtent != controlExtent.control,@"You should not try to return control extent.");
		NSCAssert(controlExtent.control != keep,@"You should not try to return keep");
		if(key){
			controlExtent.key = key;
			keep.indexLookup[key] = @(idx);
		}
		controlExtent.blockTrackers = [NSArray arrayWithArray:keep.tokenQueue];
		keep.tokenQueue = nil;
		return controlExtent;
	};
}


@implementation SHControlDictionary

-(instancetype)init:(SHControlKeep *)owner{
	if(self = [self init]){
		_owner = owner;
	}
	return self;
}


-(id)objectForKeyedSubscript:(id)key{
	if(nil == self.owner.indexLookup[key]){
		return nil;
	}
	NSUInteger idx = self.owner.indexLookup[key].unsignedIntegerValue;
	return self.owner.controlList[idx];
}


-(void)setObject:(SHVarWrapper<SHLazyLoadBlock> *)obj forKeyedSubscript:(id<NSCopying>)key{
	if(nil != self.owner.indexLookup[key]){
		NSUInteger idx = self.owner.indexLookup[key].unsignedIntegerValue;
		self.owner.controlList[idx] = [[SHVarWrapper<SHLazyLoadBlock> alloc] init:obj,nil];
	}
	else{
		[self.owner addLoaderBlock:obj.item withKey:key];
	}
}


-(void)removeObjectForKey:(id)key{
	if(nil == self.owner.indexLookup[key]){
		return;
	}
	NSUInteger idx = self.owner.indexLookup[key].unsignedIntegerValue;
	[self.owner.lazyLoaders removeObjectAtIndex:idx];
	[self.owner.controlBackend removeObjectAtIndex:idx];
	[self.owner.indexLookup removeObjectForKey:key];
}

@end



@implementation SHControlList


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
	SHControlExtent *controlExtent = self.owner.controlBackend[idx];
	if(controlExtent.control != nil){
		return controlExtent.control;
	}
	controlExtent = self.owner.lazyLoaders[idx](self.owner); //any associations will happen in the provided block
	self.owner.controlBackend[idx] = controlExtent;
	return controlExtent.control;
}


-(void)setObject:(SHVarWrapper<SHLazyLoadBlock> *)loaderBlock atIndexedSubscript:(NSUInteger)idx{
	id key = nil;
	key = [loaderBlock isKindOfClass:SHPairWrapper.class]?((SHPairWrapper *)loaderBlock).item2:nil;
	self.owner.lazyLoaders[idx] = wrapLoaderBlock(loaderBlock.item,idx,key);
	SHControlExtent *controlExtent = self.owner.controlBackend[idx];
	if(controlExtent.key){
		[self.owner.indexLookup removeObjectForKey:controlExtent.key];
	}
	if(key){
		self.owner.indexLookup[key] = [NSNumber numberWithUnsignedInteger:idx];
	}
	self.owner.controlBackend[idx] = [[SHControlExtent alloc] init];
}


-(void)setObject:(SHLazyLoadBlock)loaderBlock atIndexedSubscript:(NSUInteger)idx andKey:(id<NSCopying>)key{
	SHPairWrapper<SHLazyLoadBlock,id> *wrapper = [[SHPairWrapper<SHLazyLoadBlock,id> alloc] init:loaderBlock,key,nil];
	self[idx] = (SHVarWrapper<SHLazyLoadBlock> *)wrapper;
}


-(NSUInteger)indexOfObject:(id)object{
	for(NSUInteger i = 0;i < self.owner.controlBackend.count;i++){
		if(self.owner.controlBackend[i].control == object){
			return i;
		}
	}
	return -1;
}

@end


@implementation SHResponderDictionary


-(instancetype)init:(SHControlKeep *)owner{
	if(self = [self init]){
		_owner = owner;
	}
	return self;
}


-(AssociatedResponderAndSet *)objectForKeyedSubscript:(id<NSCopying>)key{
	return self.owner.associations[key];
}


/*
 
 */
-(void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
	AssociatedResponderAndSet *association = [self.owner getOrCreateAssociationForKey:key];
	association.responder = obj;
	for(SHSetupResponder block in association.setupActions.allValues){
		block(association.responder);
	}
}


@end


@implementation AssociatedResponderAndSet

-(instancetype)init{
	if(self = [super init]){
		_setupActions = [NSMutableDictionary dictionary];
	}
	return self;
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


-(NSMutableArray<SHControlExtent *> *)controlBackend{
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


-(SHControlDictionary *)controlLookup{
	if(nil == _controlLookup){
		_controlLookup = [[SHControlDictionary alloc] init:self];
	}
	return _controlLookup;
}


-(SHControlList *)controlList{
	if(nil == _controlList){
		_controlList = [[SHControlList alloc] init:self];
	}
	return _controlList;
}


-(SHResponderDictionary *)responderLookup{
	if(nil == _responderLookup){
		_responderLookup = [[SHResponderDictionary alloc] init:self];
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


-(AssociatedResponderAndSet *)getOrCreateAssociationForKey:(id<NSCopying>)key{
	AssociatedResponderAndSet *association = self.associations[key];
	if(nil == association){
		association = [[AssociatedResponderAndSet alloc] init];
		self.associations[key] = association;
	}
	return association;
}


-(void)addToTokenQueue:(SHPairWrapper<SHKeyToken *,id<NSCopying>> *)tokenAndKey{
	if(nil == self.tokenQueue){
		self.tokenQueue = [NSMutableArray array];
	}
	[self.tokenQueue addObject:tokenAndKey];
}

/*
 call this from a loadedBlock to add a control to the set and wireup the responder recieving
actions if it exists
 Parameters:
 key:
 setupAction: this is block that recieves a responder to respond to events emitted by
 your control
 */
-(SHKeyToken *)forResponderKey:(id<NSCopying>)key doSetupAction:(SHSetupResponder)setupAction{
	AssociatedResponderAndSet *association = [self getOrCreateAssociationForKey:key];
	SHKeyToken *token = [[SHKeyToken alloc] init];
	association.setupActions[token] = setupAction; //add to list of responses
	if(association.responder){
		setupAction(association.responder);
	}
	[self addToTokenQueue:pw(token,key)];
	return token;
}

/**
 *Add loader block that will return control
 **/
-(void)addLoaderBlock:(SHLazyLoadBlock)loaderBlock{
	[self addLoaderBlock:loaderBlock withKey:nil];
}

/*
 *same as addLoaderBlock but we're also associating this code block/control with a key
 */
-(void)addLoaderBlock:(SHLazyLoadBlock)loaderBlock withKey:(id<NSCopying,NSObject>)key{
	if(key){
		self.indexLookup[key] = [NSNumber numberWithUnsignedInteger:self.lazyLoaders.count];
	}
	[self.lazyLoaders addObject:wrapLoaderBlock(loaderBlock,self.lazyLoaders.count,key)];
	[self.controlBackend addObject:[[SHControlExtent alloc] init]];
}


-(void)cleanupSetupBlocks:(SHControlExtent *)controlExtent{
	for(SHPairWrapper<SHKeyToken *,id<NSCopying>> *pair in controlExtent.blockTrackers){
		AssociatedResponderAndSet *association = self.associations[pair.item2];
		[association.setupActions removeObjectForKey:pair.item];
	}
}


@end
