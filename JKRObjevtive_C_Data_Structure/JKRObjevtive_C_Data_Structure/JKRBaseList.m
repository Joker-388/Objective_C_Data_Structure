//
//  JKRBaseList.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBaseList.h"

@implementation JKRBaseList

- (instancetype)init {
    if (self.class == [JKRBaseList class]) {
        NSAssert(NO, @"只能使用BaseList的子类");
    }
    self = [super init];
    return self;
}

- (NSUInteger)count {
    return _size;
}

- (void)addObject:(id)anObject {
    [self insertObject:anObject atIndex:_size];
}

- (BOOL)containsObject:(id)anObject {
    return [self indexOfObject:anObject] != NSUIntegerMax;
}

- (id)firstObject {
    if (_size == 0) {
        return nil;
    }
    return [self objectAtIndex:0];
}

- (id)lastObject {
    if (_size == 0) {
        return nil;
    }
    return [self objectAtIndex:_size - 1];
}

- (void)removeFirstObject {
    if (_size == 0) {
        return;
    }
    [self removeObjectAtIndex:0];
}

- (void)removeLastObject {
    if (_size == 0) {
        return;
    }
    [self removeObjectAtIndex:_size - 1];
}

- (void)removeObject:(id)anObject {
    NSUInteger index = [self indexOfObject:anObject];
    if (index != NSUIntegerMax) {
        [self removeObjectAtIndex:index];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (idx == _size) {
        [self insertObject:obj atIndex:idx];
    } else {
        [self replaceObjectAtIndex:idx withObject:obj];
    }
}

- (void)indexOutOfBounds:(NSUInteger)index {
    NSAssert(NO, @"index: %zd, size: %zd", index, _size);
}

- (void)rangeCheckForExceptAdd:(NSUInteger)index {
    if (index < 0 || index >= _size) {
        [self indexOutOfBounds:index];
    }
}

- (void)rangeCheckForAdd:(NSUInteger)index {
    if (index < 0 || index > _size) {
        [self indexOutOfBounds:index];
    }
}

- (BOOL)isEqual:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nullable obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj];
    }];
    return [array isEqual:object];
}

@end
