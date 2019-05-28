//
//  JKRHashSet.h
//  HashMapSet
//
//  Created by Joker on 2019/5/27.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRHashSet<ObjectType> : NSObject

/// 元素个数
- (NSUInteger)count;
/// 清空所有元素
- (void)removeAllObjects;
/// 删除元素
- (void)removeObject:(nullable ObjectType)object;
/// 添加一个元素
- (void)addObject:(nullable ObjectType)object;
/// 是否包含元素
- (BOOL)containsObject:(nullable ObjectType)object;

@end

@interface JKRHashSet<ObjectType> (JKRExtendedHashSet)

- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
