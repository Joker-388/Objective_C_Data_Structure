//
//  JKRLinkedCircleList.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRLinkedCircleList.h"

@implementation JKRLinkedCircleList

- (NSUInteger)indexOfObject:(id)anObject {
    if (!anObject) {
        JKRLinkedListNode *node = _first;
        for (NSUInteger i = 0; i < _size; i++) {
            if (!node.object) {
                return i;
            }
            node = node.next;
        }
    } else {
        JKRLinkedListNode *node = _first;
        for (NSUInteger i = 0; i < _size; i++) {
            if ([anObject isEqual:node.object]) {
                return i;
            }
            node = node.next;
        }
    }
    return NSUIntegerMax;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    
    // index == size 相当于 插入到表尾 或者 空链表添加第一个节点
    if (_size == index) {
        JKRLinkedListNode *oldLast = _last;
        JKRLinkedListNode *node = [[JKRLinkedListNode alloc] initWithPrev:_last object:anObject next:_first];
        _last = node;
        if (!oldLast) { // 添加链表第一个元素
            _first = _last;
            _first.prev = _first;
            _first.next = _first;
        } else { // 插入到表尾
            oldLast.next = _last;
            _first.prev = _last;
        }
    } else { // 插入到表的非空节点的位置上
        JKRLinkedListNode *next = [self nodeWithIndex:index];
        JKRLinkedListNode *prev = next.prev;
        JKRLinkedListNode *node = [[JKRLinkedListNode alloc] initWithPrev:prev object:anObject next:next];
        next.prev = node;
        prev.next = node;
        if (next == _first) {
            _first = node;
        }
    }
    if (_first.next == _first) {
        _first.next = nil;
        _first.weakNext = _first;
    }
    _size++;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheckForExceptAdd:index];
    
    JKRLinkedListNode *node = _first;
    if (_size == 1) {
        _first = nil;
        _last = nil;
    } else {
        node = [self nodeWithIndex:index];
        JKRLinkedListNode *prev = node.prev;
        JKRLinkedListNode *next = node.next;
        prev.next = next;
        next.prev = prev;
        if (node == _first) {
            _first = next;
        }
        if (node == _last) {
            _last = prev;
        }
    }
    if (_first.next == _first) {
        _first.next = nil;
        _first.weakNext = _first;
    }
    
    _size--;
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self nodeWithIndex:index].object;
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    JKRLinkedListNode *node = [self nodeWithIndex:index];
    node.object = anObject;
}

- (void)removeAllObjects {
    _size = 0;
    // 防止循环引用造成无法清空
    _last.next = nil;
    _first = nil;
    _last = nil;
}

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nullable, NSUInteger, BOOL * _Nonnull))block {
    BOOL stop = NO;
    JKRLinkedListNode *node = _first;
    for (NSUInteger i = 0; i < _size && !stop; i++) {
        block(node.object, i, &stop);
        node = node.next;
    }
}

- (JKRLinkedListNode *)nodeWithIndex:(NSInteger)index {
    [self rangeCheckForExceptAdd:index];
    if (index < (_size >> 1)) {
        JKRLinkedListNode *node = _first;
        for (NSUInteger i = 0; i < index; i++) {
            node = node.next;
        }
        return node;
    } else {
        JKRLinkedListNode *node = _last;
        for (NSUInteger i = _size - 1; i > index; i--) {
            node = node.prev;
        }
        return node;
    }
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"Size: %zd [", _size]];
    JKRLinkedListNode *node = _first;
    for (NSInteger i = 0; i < _size; i++) {
        if (i != 0) {
            [string appendString:@", "];
        }
        [string appendString:[NSString stringWithFormat:@"%@", node]];
        node = node.next;
    }
    [string appendString:@"]"];
    return string;
}

- (void)dealloc {
//    NSLog(@"<%@: %p>: dealloc", self.class, self);
}

@end
