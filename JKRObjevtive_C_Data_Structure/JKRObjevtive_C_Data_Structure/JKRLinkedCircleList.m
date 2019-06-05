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
        // _size == 0
        if (!oldLast) { // 添加链表第一个元素
            _first = _last;
            _first.prev = _first;
            _first.next = nil;
            _first.weakNext = _first;
        } else { // 插入到表尾
            oldLast.next = _last;
            oldLast.weakNext = nil;
            _first.prev = _last;
            _last.next = nil;
            _last.weakNext = _first;
        }
    } else { // 插入到表的非空节点的位置上
        JKRLinkedListNode *next = [self nodeWithIndex:index];
        JKRLinkedListNode *prev = next.prev;
        JKRLinkedListNode *node = [[JKRLinkedListNode alloc] initWithPrev:prev object:anObject next:next];
        next.prev = node;
        // index == 0
        if (next == _first) { // 插入到表头
            _first = node;
            prev.next = nil;
            prev.weakNext = node;
        } else { // 插入到两个节点中间
            prev.next = node;
            prev.weakNext = nil;
        }
    }

    _size++;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheckForExceptAdd:index];

    if (_size == 1) { // 删除唯一的节点
        _first = nil;
        _last = nil;
    } else {
        // 被删除的节点
        JKRLinkedListNode *node = [self nodeWithIndex:index];
        // 被删除的节点的上一个节点
        JKRLinkedListNode *prev = node.prev;
        // 被删除的节点的下一个节点
        JKRLinkedListNode *next = node.next;

        if (node == _first) { // 删除头节点
            prev.next = nil;
            prev.weakNext = next;
            next.prev = prev;
            _first = next;
        } else if (node == _last) { // 删除尾节点
            prev.next = nil;
            prev.weakNext = next;
            next.prev = prev;
            _last = prev;
        } else { // 删除节点之间的节点
            prev.next = next;
            next.prev = prev;
        }
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
