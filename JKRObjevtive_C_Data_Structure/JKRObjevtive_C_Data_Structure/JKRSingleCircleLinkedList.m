//
//  JKRSingleCircleLinkedList.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRSingleCircleLinkedList.h"

@implementation JKRSingleCircleLinkedList

- (NSUInteger)indexOfObject:(id)anObject {
    if (!anObject) {
        JKRSingleLinkedListNode *node = _first;
        for (NSUInteger i = 0; i < _size; i++) {
            if (!node.object) {
                return i;
            }
            node = node.next;
        }
    } else {
        JKRSingleLinkedListNode *node = _first;
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
    if (index == 0) { // 插入链表头部或添加第一个节点
        JKRSingleLinkedListNode *node = [[JKRSingleLinkedListNode alloc] initWithObject:anObject next:_first];
        JKRSingleLinkedListNode *last = (_size == 0) ? node : [self nodeWithIndex:_size - 1];
        last.next = nil;
        last.weakNext = node;
        _first = node;
    } else { // 插入到链表尾部或链表中间
        JKRSingleLinkedListNode *prev = [self nodeWithIndex:index - 1];
        JKRSingleLinkedListNode *node = [[JKRSingleLinkedListNode alloc] initWithObject:anObject next:prev.next];
        prev.next = node;
        prev.weakNext = nil;
        if (node.next == _first) { // 插入到链表尾部
            node.next = nil;
            node.weakNext = _first;
        }
    }
    _size++;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheckForExceptAdd:index];
    
    JKRSingleLinkedListNode *node = _first;
    if (index == 0) { // 删除头节点或者唯一的节点
        if (_size == 1) { // 删除唯一的节点
            _first = nil;
        } else { // 删除头节点
            JKRSingleLinkedListNode *last = [self nodeWithIndex:_size - 1];
            _first = _first.next;
            last.next = nil;
            last.weakNext = _first;
        }
    } else { // 删除尾节点或中间的节点
        JKRSingleLinkedListNode *prev = [self nodeWithIndex:index - 1];
        node = prev.next;
        if (node.next == _first) { // 删除尾节点
            prev.next = nil;
            prev.weakNext = _first;
        } else { // 删除中间节点
            prev.next = node.next;
            prev.weakNext = nil;
        }
    }
    _size--;
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self nodeWithIndex:index].object;
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    JKRSingleLinkedListNode *node = [self nodeWithIndex:index];
    node.object = anObject;
}

- (void)removeAllObjects {
    if (_size == 0) return;
    _size = 0;
    _first = nil;
}

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nullable, NSUInteger, BOOL * _Nonnull))block {
    BOOL stop = NO;
    JKRSingleLinkedListNode *node = _first;
    for (NSUInteger i = 0; i < _size && !stop; i++) {
        block(node.object, i, &stop);
        node = node.next;
    }
}

- (JKRSingleLinkedListNode *)nodeWithIndex:(NSInteger)index {
    [self rangeCheckForExceptAdd:index];
    JKRSingleLinkedListNode *node = _first;
    for (NSInteger i = 0; i < index; i++) {
        node = node.next;
    }
    return node;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"Size: %zd [", _size]];
    JKRSingleLinkedListNode *node = _first;
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
    NSLog(@"<%@: %p>: dealloc", self.class, self);
}

@end
