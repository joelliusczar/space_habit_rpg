//
//	SHModelError.h
//	SHModels
//
//	Created by Joel Pridgen on 4/25/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int,SHSeverity){
	SH_SEVERITY_NONE,
	SH_SEVERITY_WARN,
	SH_SEVERITY_ERR
};

NS_ASSUME_NONNULL_BEGIN

@interface SHModelError : NSObject
-(instancetype)initWithPropertyName:(NSString*)name
	errorDescription:(NSString*)description
	errorLevel:(SHSeverity)level;
+(instancetype)newWithPropertyName:(NSString*)name
	errorDescription:(NSString*)description
	errorLevel:(SHSeverity)level;
@property (strong,nonatomic) NSString *propertyName;
@property (strong,nonatomic) NSString *errorDesc;
@property (nonatomic) SHSeverity errorLevel;
@end

NS_ASSUME_NONNULL_END
