//
//  NSNumber+JKRDataStructure.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRArrayList.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (JKRDataStructure)

/// 随机数组
+ (JKRArrayList<NSNumber *> *)jkr_randomArrayWithCount:(NSUInteger)count min:(NSInteger)min max:(NSInteger)max;
/// 升序数组
+ (JKRArrayList<NSNumber *> *)jkr_ascendingOrderArrayWithMin:(NSInteger)min max:(NSInteger)max;
/// 数组是否升序
+ (BOOL)jkr_isAscendingOrder:(JKRArrayList<NSNumber *> *)array;

/// 中间是生序的数组
+ (JKRArrayList<NSNumber *> *)jkr_centerAsAscendingOrderArrayWithMin:(NSInteger)min max:(NSInteger)max disorderCount:(NSUInteger)disorderCount;

/// 中间是生序的数组
+ (JKRArrayList<NSNumber *> *)jkr_tailAsAscendingOrderArrayWithMin:(NSInteger)min max:(NSInteger)max disorderCount:(NSUInteger)disorderCount;

@end

NS_ASSUME_NONNULL_END
