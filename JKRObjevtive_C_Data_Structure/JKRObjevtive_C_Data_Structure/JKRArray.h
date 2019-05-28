//
//  JKRArray.h
//  HashMapSet
//
//  Created by Joker on 2019/5/22.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRArray<ObjectType> : NSObject<NSFastEnumeration>  {
@protected
    void ** _array;
    NSUInteger _length;
}

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;

+ (instancetype)arrayWithLength:(NSUInteger)length;

- (instancetype)initWithLength:(NSUInteger)length;
- (NSUInteger)length;
- (void)setObject:(nullable ObjectType)object AtIndex:(NSUInteger)index;
- (nullable ObjectType)objectAtIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(nullable ObjectType)object;
- (BOOL)containsObject:(ObjectType)object;

@end

@interface JKRArray<ObjectType> (JKRExtendedArray)

- (void)enumerateObjectsUsingBlock:(void (^)(_Nullable ObjectType obj, NSUInteger idx, BOOL *stop))block;
- (_Nullable ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(_Nullable ObjectType)obj atIndexedSubscript:(NSUInteger)idx;

@end

@interface JKRArray<ObjectType> (NSGenericFastEnumeraiton) <NSFastEnumeration>

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained _Nullable [_Nonnull])buffer count:(NSUInteger)len;

@end

NS_ASSUME_NONNULL_END
