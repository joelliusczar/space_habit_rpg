//
//  SHControlArray.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

/*
 SHControlKeep:
 Uses: loop through a list of lazy loaded controls.
 Controls are provided by means of code blocks
 The code block can be added to .controlList
 It can be added with a key to .controlLookup
 You can associate a responder to respond to events generated by the control
 If you added the code block/control with a key,
 you can associated the responder with that key by adding it to .responderLookup
 */

#import <Foundation/Foundation.h>
#import "SHVarWrapper.h"
#import "SHControlKeepProtocol.h"
#import "SHKeyToken.h"

#define takeKey(methodName) [SELPtr sel:@selector(methodName)]
#define takeKey_s(methodName) [SELPtr selName:methodName]


@class SHControlKeep;



@interface SHControlExtent: NSObject
@property (strong,nonatomic) id<NSCopying> key;
@property (assign,nonatomic) NSUInteger idx;
@property (strong,nonatomic) id control;
@property (strong,nonatomic) NSArray<SHPairWrapper<SHKeyToken *,id<NSCopying>> *> *blockTrackers;
-(instancetype)copyExtent;
@end

typedef id (^SHLazyLoadBlock)(SHControlKeep *,SHControlExtent *);
typedef void (^SHSetupResponder)(id responder);

@interface AssociatedResponderAndSet<T_Responder>: NSObject
@property (weak,nonatomic) T_Responder responder;
@property (strong,nonatomic) NSMutableDictionary<SHKeyToken *,SHSetupResponder> *setupActions;
@end


/**
 *ControlDictionary is a private class designed to be used by SHControlKeep
 *We stores code blocks in a dictionary
 **/
@interface SHControlDictionary<T_Control>: NSObject
@property (readonly,assign,nonatomic) NSUInteger count;
@property (weak,nonatomic) SHControlKeep *owner;
-(T_Control)objectForKeyedSubscript:(id)key;
-(void)setObject:(SHVarWrapper<SHLazyLoadBlock> *)obj forKeyedSubscript:(id<NSCopying>)key;
-(void)removeObjectForKey:(id)key;
-(instancetype)init:(SHControlKeep *)owner;
@end

/**
 *Use this when you need to iterate through controls, if there is no control,
 we call the control block to initialize the control. Either way a control is getting
 returned.
 **/
@interface SHControlList<T_Control>: NSObject
@property (weak,nonatomic) SHControlKeep *owner;
/*number of controls stored in keep*/
@property (readonly,nonatomic) NSUInteger count;
-(T_Control)objectAtIndexedSubscript:(NSUInteger)idx;
-(NSUInteger)indexOfObject:(T_Control)object;
-(void)setObject:(SHVarWrapper<SHLazyLoadBlock> *)loaderBlock atIndexedSubscript:(NSUInteger)idx;
-(void)setObject:(SHLazyLoadBlock)loaderBlock atIndexedSubscript:(NSUInteger)idx andKey:(id<NSCopying>)key;
-(instancetype)init:(SHControlKeep *)owner;
@end


@interface SHResponderDictionary<T_Responder>: NSObject
@property (weak,nonatomic) SHControlKeep *owner;
-(void)setObject:(T_Responder)obj forKeyedSubscript:(id<NSCopying>)key;
-(AssociatedResponderAndSet *)objectForKeyedSubscript:(id<NSCopying>)key;
-(instancetype)init:(SHControlKeep *)owner;
@end


@interface SHControlKeep<T_Control,T_Responder> : NSObject<SHControlKeepProtocol>
/*number of delegates that controls might be associated with. This count can include nills*/
@property (readonly,nonatomic) NSUInteger associatedCount;
@property (strong,nonatomic) NSMutableDictionary *customProps;
@property (strong,nonatomic) SHControlDictionary<T_Control> *controlLookup; //this will only have values specifically defined by client
@property (strong,nonatomic) SHControlList<T_Control> *controlList;
@property (strong,nonatomic) SHResponderDictionary<T_Responder> *responderLookup;
-(SHKeyToken *)forResponderKey:(id<NSCopying>)key doSetupAction:(SHSetupResponder)setupAction;
/*Add loader block that will return control*/
-(void)addLoaderBlock:(SHLazyLoadBlock)loaderBlock;
/*same as addLoaderBlock but we're also associating this code block/control with a key
 if the client sets key through here, it overrides key set on the controlExtent inside
 the loader block*/
-(void)addLoaderBlock:(SHLazyLoadBlock)loaderBlock withKey:(id<NSCopying>)key;
@end



