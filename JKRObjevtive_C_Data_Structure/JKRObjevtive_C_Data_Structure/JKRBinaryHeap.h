//
//  JKRBinaryHeap.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBaseHeap.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger(^jkrbinaryheap_compareBlock)(id e1, id e2);

@interface JKRBinaryHeap<ObjectType> : JKRBaseHeap<ObjectType> {
@protected
    jkrbinaryheap_compareBlock _compareBlock;
}

/// 初始化二叉堆
/// @discussion 加入的对象是系统默认的带有compare:方法的类的实例
/// @param compare 比较方案 大顶堆 return e1 - e2 小顶堆 return e2 - e1
- (instancetype)initWithCompare:(nullable jkrbinaryheap_compareBlock)compare;


/// 快速建大顶堆
/// @param array 数组
- (instancetype)initWithArray:(nullable NSArray *)array;


/// 快速建堆
/// @param array 数组
/// @param compare 比较方案 大顶堆 return e1 - e2 小顶堆 return e2 - e1
- (instancetype)initWithArray:(nullable NSArray *)array compare:(nullable jkrbinaryheap_compareBlock)compare;

@end

NS_ASSUME_NONNULL_END
