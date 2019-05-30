//
//  JKRArray.m
//  HashMapSet
//
//  Created by Joker on 2019/5/22.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRArray.h"

@implementation JKRArray

#pragma mark - 初始化
+ (instancetype)arrayWithLength:(NSUInteger)length {
    return [[[self alloc] initWithLength:length] autorelease];
}

- (instancetype)initWithLength:(NSUInteger)length {
    self = [super init];
    _length = length;
    _array = new void*[length]();
    return self;
}

#pragma mark - dealloc
- (void)dealloc {
    for (NSUInteger i = 0; i < _length; i++) {
        id object = [self objectAtIndex:i];
        if (object) [object release];
    }
    delete _array;
//    NSLog(@"<%@, %p> dealloc", self.class, self);
    [super dealloc];
}

#pragma mark - 返回长度
- (NSUInteger)length {
    return _length;
}

#pragma mark - 添加元素
- (void)setObject:(id)object AtIndex:(NSUInteger)index {
    [self checkRangeWithIndex:index];
    id oldObject = [self objectAtIndex:index];
    if (oldObject == object) return;
    if (oldObject != nil) [oldObject release];
    if (object) [object retain];
    *(_array + index) = (__bridge void *)object;
}

#pragma mark - 获取元素
- (id)objectAtIndex:(NSUInteger)index {
    [self checkRangeWithIndex:index];
    id object = (__bridge id)(*(_array + index));
    return object;
}

#pragma mark - 删除元素
- (void)removeObjectAtIndex:(NSUInteger)index {
    [self checkRangeWithIndex:index];
    id object = (__bridge id)(*(_array + index));
    if (object) [object release];
    *(_array + index) = 0;
}

#pragma mark - 元素在数组中存储的第一个下标
- (NSUInteger)indexOfObject:(id)object {
    __block NSUInteger index = NSUIntegerMax;
    [self enumerateObjectsUsingBlock:^(id  _Nullable obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (object == obj) {
            index = idx;
            *stop = YES;
        } else if ([object isEqual:obj]){
            index = idx;
            *stop = YES;
        } 
    }];
    return index;
}

#pragma mark - 是否包含
- (BOOL)containsObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    return index < _length;
}

#pragma mark - 枚举
- (void)enumerateObjectsUsingBlock:(void (^)(id _Nullable, NSUInteger, BOOL * _Nonnull))block {
    BOOL stop = NO;
    for (NSUInteger i = 0; i < _length && !stop; i++) {
        id object = [self objectAtIndex:i];
        block(object, i, &stop);
    }
}

#pragma mark - 边界检查
- (void)checkRangeWithIndex:(NSUInteger)index {
    if (index < 0 || index >= _length) NSAssert(NO, @"Index: %zd, Length: %zd", index, _length);
}

#pragma mark - 支持数组运算符
- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    [self setObject:obj AtIndex:idx];
}

#pragma mark - 快速遍历
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable [])buffer count:(NSUInteger)len {
    if (state->state > 0) return 0;
    state->mutationsPtr = (unsigned long*)self;
    NSUInteger retCount = state->extra[0];
    state->itemsPtr = (id *)(_array + state->extra[1]);
    if (retCount == 0) retCount = _length;
    if (retCount > len) {
        state->extra[0] = retCount - len;
        state->extra[1] += len;
        retCount = len;
    } else {
        state->state++;
    }
    return retCount;
}

#pragma mark - 打印
- (NSString *)description {
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString appendString:[NSString stringWithFormat:@"<%@: %p>: \nlength: %zd\n{\n", self.class, self, _length]];
    for (NSUInteger i = 0; i < _length; i++) {
        if (i) [mutableString appendString:@"\n"];
        id object = [self objectAtIndex:i];
        if (object) {
            [mutableString appendString:@"   "];
            [mutableString appendString:[object description]];
        } else {
            [mutableString appendString:@"   "];
            [mutableString appendString:@"Null"];
        }
    }
    [mutableString appendString:@"\n}"];
    return mutableString;
}

@end

