//
//  JKRTreeMap.h
//  TreeMapSet
//
//  Created by Lucky on 2019/5/18.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef int(^jkrmap_compareBlock)(id e1, id e2);

/*
 红黑树实现Map
 基于红黑树的性质，添加的元素必须具有可比较性
 */

@class JKRTreeMapNode;

@interface JKRTreeMap<KeyType, ObjectType> : NSObject {
@protected
    /// 节点个数
    NSUInteger _size;
    /// 跟节点
    JKRTreeMapNode *_root;
    /// 比较器
    jkrmap_compareBlock _compareBlock;
}

/// 通过比较器初始化，如果不使用则默认通过添加元素的compare方法比较
- (instancetype)initWithCompare:(_Nonnull jkrmap_compareBlock)compare;
/// 元素个数
- (NSUInteger)count;
/// 清空所有元素
- (void)removeAllObjects;
/// 删除元素
- (void)removeObjectForKey:(KeyType)key;
/// 添加一个元素
- (void)setObject:(nullable ObjectType)object forKey:(KeyType)key;
/// 获取元素
- (nullable ObjectType)objectForKey:(KeyType)key;
/// 是否包含元素
- (BOOL)containsObject:(nullable ObjectType)object;
/// 是否包含key
- (BOOL)containsKey:(KeyType)key;

@end

@interface JKRTreeMap<KeyType, ObjectType> (JKRExtendedTreeMap)

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;
- (nullable ObjectType)objectForKeyedSubscript:(nullable KeyType)key;
- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(nullable KeyType)key;

@end

NS_ASSUME_NONNULL_END
