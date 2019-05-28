//
//  JKRLinkedList.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRLinkedList.h"

@implementation JKRLinkedList

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
    
    if (index == _size) {
        JKRLinkedListNode *oldLast = _last;
        JKRLinkedListNode *node = [[JKRLinkedListNode alloc] initWithPrev:_last object:anObject next:nil];
        _last = node;
        if (!oldLast) {
            _first = _last;
        } else {
            oldLast.next = _last;
        }
    } else {
        JKRLinkedListNode *next = [self nodeWithIndex:index];
        JKRLinkedListNode *prev = next.prev;
        JKRLinkedListNode *node = [[JKRLinkedListNode alloc] initWithPrev:prev object:anObject next:next];
        next.prev = node;
        if (!prev) {
            _first = node;
        } else {
            prev.next = node;
        }
    }
    _size++;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheckForExceptAdd:index];
    JKRLinkedListNode *node = [self nodeWithIndex:index];
    JKRLinkedListNode *prev = node.prev;
    JKRLinkedListNode *next = node.next;
    if (node == _first) {
        _first = next;
    } else {
        prev.next = next;
    }
    
    if (node == _last) {
        _last = prev;
    } else {
        next.prev = prev;
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
