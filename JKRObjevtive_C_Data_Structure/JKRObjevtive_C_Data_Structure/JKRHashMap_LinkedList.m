//
//  JKRHashMap_LinkedList.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/6/5.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRHashMap_LinkedList.h"
#import "JKRArray.h"

@interface JKRHashMap_LinkedList_Node : NSObject

@property (nonatomic, strong) id key;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) JKRHashMap_LinkedList_Node *next;

@end

@interface JKRHashMap_LinkedList ()

@property (nonatomic, strong) JKRArray *array;

@end

@implementation JKRHashMap_LinkedList

- (instancetype)init {
    self = [super init];
    self.array = [JKRArray arrayWithLength:1 << 4];
    return self;
}

- (void)removeAllObjects {
    if (_size == 0) return;
    _size = 0;
    for (NSUInteger i = 0; i < self.array.length; i++) {
        self.array[i] = nil;
    }
}

- (id)objectForKey:(id)key {
    JKRHashMap_LinkedList_Node *node = [self nodeWithKey:key];
    return node ? node.value : nil;
}

- (BOOL)containsKey:(id)key {
    return [self nodeWithKey:key] != nil;
}

- (BOOL)containsObject:(id)object {
    if (_size == 0) {
        return NO;
    }
    
    for (NSUInteger i = 0; i < self.array.length; i++) {
        JKRHashMap_LinkedList_Node *node= self.array[i];
        while (node) {
            if (node.value == object || [node.value isEqual:object]) {
                return YES;
            }
            node = node.next;
        }
    }
    return NO;
}

- (void)removeObjectForKey:(id)key {
    NSUInteger index = [self indexWithKey:key];
    JKRHashMap_LinkedList_Node *node= self.array[index];
    JKRHashMap_LinkedList_Node *preNode = nil;
    while (node) {
        if (node.key == key || [node.key isEqual:key]) {
            if (preNode) {
                preNode.next = node.next;
            } else {
                self.array[index] = node.next;
            }
            _size--;
            return;
        } else if (key && node.key && [key class] == [node.key class] && [key respondsToSelector:@selector(compare:)] && [key compare:node.key] == 0){
            if (preNode) {
                preNode.next = node.next;
            } else {
                self.array[index] = node.next;
            }
            _size--;
            return;
        }
        preNode = node;
        node = node.next;
    }
}

- (NSUInteger)count {
    return _size;
}

- (void)setObject:(id)object forKey:(id)key {
    [self resize];
    
    NSUInteger index = [self indexWithKey:key];
    JKRHashMap_LinkedList_Node *node = self.array[index];
    if (!node) {
        node = [JKRHashMap_LinkedList_Node new];
        node.key = key;
        node.value = object;
        self.array[index] = node;
        _size++;
        return;
    }
    
    JKRHashMap_LinkedList_Node *preNode = nil;
    while (node) {
        if (node.key == key || [node.key isEqual:key]) {
            break;
        } else if (key && node.key && [key class] == [node.key class] && [key respondsToSelector:@selector(compare:)] && [key compare:node.key] == 0) {
            break;
        }
        preNode = node;
        node = node.next;
    }
    
    if (node) {
        node.key = key;
        node.value = object;
        return;
    }
    
    JKRHashMap_LinkedList_Node *newNode = [JKRHashMap_LinkedList_Node new];
    newNode.key = key;
    newNode.value = object;
    preNode.next = newNode;
    _size++;
}

- (void)resize {
    if (_size <= self.array.length * 0.75) return;
    JKRArray *oldArray = self.array;
    self.array = [JKRArray arrayWithLength:oldArray.length << 1];
//    NSLog(@"扩容 %zd -> %zd", oldArray.length ,self.array.length);

    for (NSUInteger i = 0; i < oldArray.length; i++) {
        JKRHashMap_LinkedList_Node *node = oldArray[i];
        while (node) {
            JKRHashMap_LinkedList_Node *moveNode = node;
            node = node.next;
            moveNode.next = nil;
            [self moveNode:moveNode];
        }
    }
}

- (void)moveNode:(JKRHashMap_LinkedList_Node *)newNode {
    NSUInteger index = [self indexWithKey:newNode.key];
    JKRHashMap_LinkedList_Node *node = self.array[index];
    if (!node) {
        self.array[index] = newNode;
        return;
    }
    JKRHashMap_LinkedList_Node *preNode = nil;
    while (node) {
        preNode = node;
        node = node.next;
    }
    preNode.next = newNode;
}

#pragma mark - 获取哈希表节点
- (JKRHashMap_LinkedList_Node *)nodeWithKey:(id)key {
    NSUInteger index = [self indexWithKey:key];
    JKRHashMap_LinkedList_Node *node= self.array[index];
    while (node) {
        if (node.key == key || [node.key isEqual:key]) {
            return node;
        } else if (key && node.key && [key class] == [node.key class] && [key respondsToSelector:@selector(compare:)] && [key compare:node.key] == 0){
            return node;
        }
        node = node.next;
    }
    return node;
}

- (NSUInteger)indexWithKey:(id)key {
    if (!key) return 0;
    NSUInteger hash = [key hash];
    return (hash ^ (hash >> 16)) & (self.array.length - 1);
}

#pragma mark - 运算符重载
- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj forKey:key];
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"<%@, %p>: \ncount:%zd length:%zd\n{\n", self.className, self, _size, self.array.length]];
    for (NSUInteger i = 0; i < self.array.length; i++) {
        [string appendString:[NSString stringWithFormat:@"\n\n--- index: %zd ---\n\n", i]];
        JKRHashMap_LinkedList_Node *node= self.array[i];
        if (node) {
            while (node) {
                [string appendString:[NSString stringWithFormat:@"[%@:%@ -> %@%@] ", node.key , node.value, node.next ? [NSString stringWithFormat:@"%@:", node.next.key] : @"NULL", node.next ? node.next.value : @""]];
                node = node.next;
                if (i) {
                    [string appendString:@", "];
                }
            }
        } else {
            [string appendString:@"   "];
            [string appendString:@"NULL"];;
        }
    }
    [string appendString:@"\n\n}"];
    return string;
}

@end

@implementation JKRHashMap_LinkedList_Node


@end
