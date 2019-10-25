//
//	ArcLessObj.h
//	ObjCPlayground
//
//	Created by Joel Pridgen on 3/9/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface ArcLessObj : NSObject
+(instancetype)extraNew;
+(instancetype)newExtraRelease;
+(instancetype)otherNew;
@property (strong,nonatomic) NSString* nombre;
-(void)doATrick;
@end

NS_ASSUME_NONNULL_END
