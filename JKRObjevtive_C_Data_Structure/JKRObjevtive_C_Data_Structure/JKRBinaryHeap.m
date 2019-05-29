//
//  JKRBinaryHeap.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBinaryHeap.h"
#import "JKRArray.h"
#import "LevelOrderPrinter.h"

#define BINARY_HEAP_DEAFULT_CAPACITY (1<<4)

@interface JKRBinaryHeap ()<LevelOrderPrinterDelegate>

@property (nonatomic, strong) JKRArray *array;

@end

@implementation JKRBinaryHeap

- (instancetype)init {
    return [self initWithArray:nil compare:nil];
}

- (instancetype)initWithCompare:(jkrbinaryheap_compareBlock)compare {
    return [self initWithArray:nil compare:compare];
}

- (instancetype)initWithArray:(NSArray *)array {
    return [self initWithArray:array compare:nil];
}

- (instancetype)initWithArray:(NSArray *)array compare:(jkrbinaryheap_compareBlock)compare {
    self = [super init];
    if (!array || array.count == 0) {
        self.array = [JKRArray arrayWithLength:BINARY_HEAP_DEAFULT_CAPACITY];
    } else {
        self.array = [JKRArray arrayWithLength:array.count > BINARY_HEAP_DEAFULT_CAPACITY ? array.count : BINARY_HEAP_DEAFULT_CAPACITY];
        for (NSUInteger i = 0; i < array.count; i++) {
            self.array[i] = array[i];
        }
        _size = array.count;
        [self heapity];
    }
    _compareBlock = compare;
    return self;
}

- (void)removeAllObjects {
    if (_size == 0) {
        return;
    }
    for (NSUInteger i = 0; i < _size; i++) {
        self.array[i] = nil;
    }
    _size = 0;
}

- (id)top {
    if (!_size) {
        return nil;
    }
    return self.array[0];
}

- (void)addObject:(id)anObject {
    [self objectNotNullCheck:anObject];
    [self ensureCapacityWithCapacity:_size + 1];
    self.array[_size++] = anObject;
    [self siftUpWithIndex:_size - 1];
}

- (void)removeTop {
    NSUInteger lastIndex = --_size;
    self.array[0] = self.array[lastIndex];
    self.array[lastIndex] = nil;
    [self siftDownWithIndex:0];
}

- (void)replaceTop:(id)anObject {
    [self objectNotNullCheck:anObject];
    self.array[0] = anObject;
    if (_size == 0) {
        _size++;
    } else {
        [self siftDownWithIndex:0];
    }
}

// 上滤
- (void)siftUpWithIndex:(NSUInteger)index {
    id object = self.array[index];
    while (index > 0) {
        NSInteger parentIndex = (index - 1) >> 1;
        id parent = self.array[parentIndex];
        if ([self compareValue1:object value2:parent] <= 0) break;
        self.array[index] = self.array[parentIndex];
        index = parentIndex;
    }
    self.array[index] = object;
}

// 下滤
- (void)siftDownWithIndex:(NSUInteger)index {
    id object = self.array[index];
    while (index < _size >> 1) {
        NSUInteger leftIndex = (index << 1) + 1;
        NSUInteger rightIndex = leftIndex + 1;
        NSUInteger maxChildIndex = (rightIndex < _size && [self compareValue1:self.array[rightIndex] value2:self.array[leftIndex]] > 0) ? rightIndex : leftIndex;
        id child = self.array[maxChildIndex];
        if ([self compareValue1:object value2:child] >= 0) break;
        self.array[index] = child;
        index = maxChildIndex;
    }
    self.array[index] = object;
}

// 自下而上的下滤 O(n)
- (void)heapity {
    for (NSInteger i = (_size >> 1) - 1; i >= 0; i--) {
        [self siftDownWithIndex:i];
    }
}

- (NSInteger)compareValue1:(id)value1 value2:(id)value2 {
    NSInteger result = 0;
    if (_compareBlock) {
        result = _compareBlock(value1, value2);
    } else if ([value1 respondsToSelector:@selector(compare:)]) {
        result = [value1 compare:value2];
    } else {
        NSAssert(NO, @"object can not compare!");
    }
    return result;
}

- (void)objectNotNullCheck:(id)anObject {
    if (!anObject) {
        NSAssert(NO, @"object must not be null!");
    }
}

- (void)ensureCapacityWithCapacity:(NSUInteger)capacity {
    NSUInteger oldCapacity = self.array.length;
    if (oldCapacity >= capacity) {
        return;
    }
    NSUInteger newCapacity = oldCapacity + (oldCapacity >> 1);
    JKRArray *newArray = [JKRArray arrayWithLength:newCapacity];
    for (NSUInteger i = 0; i < _size; i++) {
        newArray[i] = self.array[i];
    }
    self.array = newArray;
}

- (NSString *)description {
    return [LevelOrderPrinter printStringWithTree:self];
}

- (id)print_root {
    return [NSNumber numberWithInteger:0];
}

- (id)print_left:(id)node {
    NSUInteger index = ((NSNumber *)node).integerValue;
    index = (index << 1) + 1;
    return index >= _size ? nil : [NSNumber numberWithInteger:index];
}

- (id)print_right:(id)node {
    NSUInteger index = ((NSNumber *)node).integerValue;
    index = (index << 1) + 2;
    return index >= _size ? nil : [NSNumber numberWithInteger:index];
}

- (id)print_string:(id)node {
    NSUInteger index = ((NSNumber *)node).integerValue;
    return self.array[index];
}

@end
