//
//  JKRArrayList.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBaseList.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRArrayList<ObjectType> : JKRBaseList<ObjectType><NSCopying>

+ (instancetype)array;
+ (instancetype)arrayWithCapacity:(NSUInteger)capacity;
- (instancetype)initWithCapacity:(NSUInteger)capacity;

@end

@interface JKRArrayList<ObjectType> (NSGenericFastEnumeraiton) <NSFastEnumeration>

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id  _Nullable [_Nonnull])buffer count:(NSUInteger)len;

@end

NS_ASSUME_NONNULL_END
