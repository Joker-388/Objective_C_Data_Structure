//
//  JKRArrayList.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRArrayList.h"
#import "JKRArray.h"

#define JKRARRAY_LIST_DEFAULT_CAPACITY (1<<4)

@interface JKRArrayList ()

@property (nonatomic, strong) JKRArray *array;

@end

@implementation JKRArrayList {
    NSInteger _countByEnumCount;
}

+ (instancetype)array {
    return [[self alloc] initWithCapacity:JKRARRAY_LIST_DEFAULT_CAPACITY];
}

+ (instancetype)arrayWithCapacity:(NSUInteger)capacity {
    return [[self alloc] initWithCapacity:capacity];
}

- (instancetype)init {
    return [self initWithCapacity:JKRARRAY_LIST_DEFAULT_CAPACITY];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    _countByEnumCount = -1;
    self.array = [JKRArray arrayWithLength:capacity > JKRARRAY_LIST_DEFAULT_CAPACITY ? capacity : JKRARRAY_LIST_DEFAULT_CAPACITY];
    return self;
}

- (NSUInteger)indexOfObject:(id)anObject {
    if (!anObject) {
        for (NSUInteger i = 0; i < _size; i++) {
            if (self.array[i] == nil) {
                return i;
            }
        }
    } else {
        for (NSUInteger i = 0; i < _size; i++) {
            if ([anObject isEqual:self.array[i]]) {
                return i;
            }
        }
    }
    return NSUIntegerMax;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    [self ensureCapacityWithCapacity:_size + 1];
    for (NSUInteger i = _size; i > index; i--) {
        self.array[i] = self.array[i - 1];
    }
    self.array[index] = anObject;
    _size++;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheckForExceptAdd:index];
    for (NSUInteger i = index + 1; i < _size; i++) {
        self.array[i - 1] = self.array[i];
    }
    self.array[--_size] = nil;
}

- (void)removeAllObjects {
    if (_size == 0) return;
    for (NSUInteger i = 0; i < _size; i++) {
        self.array[i] = nil;
    }
    _size = 0;
}

- (id)objectAtIndex:(NSUInteger)index {
    [self rangeCheckForExceptAdd:index];
    return self.array[index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self rangeCheckForExceptAdd:index];
    self.array[index] = anObject;
}

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nullable, NSUInteger, BOOL * _Nonnull))block {
    BOOL stop = NO;
    for (NSUInteger i = 0; i < _size && !stop; i++) {
        block(self.array[i], i, &stop);
    }
}

- (void)ensureCapacityWithCapacity:(NSUInteger)capacity {
    NSUInteger oldCapacity = self.array.length;
    if (oldCapacity >= capacity) {
        return;
    }
    NSUInteger newCapacity = oldCapacity + (oldCapacity >> 1);
//    NSLog(@"--- 扩容: %zd -> %zd ---", oldCapacity, newCapacity);
    JKRArray *newArray = [JKRArray arrayWithLength:newCapacity];
    for (NSUInteger i = 0; i < _size; i++) {
        newArray[i] = self.array[i];
    }
    self.array = newArray;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"[%@, %p]: size=%zd \n{ \n", [self class], self, _size]];
    [self enumerateObjectsUsingBlock:^(id  _Nullable obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx) {
            [string appendString:@",\n"];
        }
        [string appendString:[NSString stringWithFormat:@"   %@", obj]];
    }];
    [string appendString:@"\n}"];
    return string;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id  _Nullable [])buffer count:(NSUInteger)len {
    if (state->state > 0) return 0;
    if (_countByEnumCount < 0) _countByEnumCount = _size;
    NSUInteger res = [_array countByEnumeratingWithState:state objects:buffer count:len];
    _countByEnumCount -= res;
    if (_countByEnumCount < 0) {
        state->state++;
        return res + _countByEnumCount;
    }
    return res;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    JKRArrayList *array = [[JKRArrayList alloc] initWithCapacity:self.array.length];
    array->_size = _size;
    for (NSUInteger i = 0; i < self.count; i++) {
        array[i] = self[i];
    }
    return array;
}

@end
