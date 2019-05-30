//
//  JKRBaseList.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRBaseList<ObjectType> : NSObject {
@protected
    NSUInteger _size;
}

- (NSUInteger)count;
- (void)rangeCheckForAdd:(NSUInteger)index;
- (void)rangeCheckForExceptAdd:(NSUInteger)index;
- (void)addObject:(nullable ObjectType)anObject;
- (BOOL)containsObject:(nullable ObjectType)anObject;
- (nullable ObjectType)firstObject;
- (nullable ObjectType)lastObject;
- (void)removeFirstObject;
- (void)removeLastObject;
- (void)removeObject:(nullable ObjectType)anObject;
- (_Nullable ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(_Nullable ObjectType)obj atIndexedSubscript:(NSUInteger)idx;

@end

@interface JKRBaseList<ObjectType> (JKRBaseList)

- (void)insertObject:(nullable ObjectType)anObject atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(nullable ObjectType)anObject;
- (nullable ObjectType)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(nullable ObjectType)anObject;
- (void)removeAllObjects;
- (void)enumerateObjectsUsingBlock:(void (^)(_Nullable ObjectType obj, NSUInteger idx, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
