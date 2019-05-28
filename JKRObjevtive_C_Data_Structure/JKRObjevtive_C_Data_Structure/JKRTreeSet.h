//
//  JKRTreeSet.h
//  TreeMapSet
//
//  Created by Lucky on 2019/5/18.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRTreeMap.h"


NS_ASSUME_NONNULL_BEGIN

/*
 红黑树Map实现的Set
 基于红黑树的性质，添加的元素必须具有可比较性
 */
@interface JKRTreeSet<ObjectType> : NSObject

/// 通过比较器初始化，如果不使用则默认通过添加元素的compare方法比较
- (instancetype)initWithCompare:(_Nonnull jkrmap_compareBlock)compare;
/// 元素个数
- (NSUInteger)count;
/// 清空所有元素
- (void)removeAllObjects;
/// 删除元素
- (void)removeObject:(ObjectType)object;
/// 添加一个元素
- (void)addObject:(ObjectType)object;
/// 是否包含元素
- (BOOL)containsObject:(ObjectType)object;

@end

@interface JKRTreeSet<ObjectType> (JKRExtendedTreeSet)

- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
