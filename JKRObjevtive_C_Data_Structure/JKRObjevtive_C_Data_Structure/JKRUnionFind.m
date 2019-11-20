//
//  JKRUnionFind.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/20.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind.h"

@interface JKRUnionNode<ObjectType> : NSObject

@property (nonatomic, strong) ObjectType value;
@property (nonatomic, weak) JKRUnionNode<ObjectType> *parent;
@property (nonatomic, assign) NSInteger rank;

- (instancetype)initWithValue:(ObjectType)value;

@end

@implementation JKRUnionNode

- (instancetype)initWithValue:(id)value {
    self = [super init];
    self.value = value;
    self.rank = 1;
    self.parent = self;
    return self;
}

@end

@interface JKRUnionFind<ObjectType> () {
@private
    NSMutableDictionary<id, JKRUnionNode<id> *> *_nodes;
}

@end

@implementation JKRUnionFind

- (instancetype)init {
    self = [super init];
    _nodes = [NSMutableDictionary dictionary];
    return self;
}

- (void)makeSetWithValue:(id)value {
    if ([[_nodes allKeys] containsObject:value]) return;
    [_nodes setObject:[[JKRUnionNode alloc] initWithValue:value] forKey:value];
}

- (JKRUnionNode *)findNodeWithValue:(id)value {
    JKRUnionNode *node = _nodes[value];
    if (!node) {
        return nil;
    }
    while (![node.value isEqual:node.parent.value]) {
        node.parent = node.parent.parent;
        node = node.parent;
    }
    return node;
}

- (id<NSCopying>)findWithValue:(id<NSCopying>)value {
    JKRUnionNode *node = [self findNodeWithValue:value];
    return node.value;
}

- (void)unionWithValue1:(id<NSCopying>)value1 value2:(id<NSCopying>)value2 {
    JKRUnionNode *p1 = [self findNodeWithValue:value1];
    JKRUnionNode *p2 = [self findNodeWithValue:value2];
    if (!p1 || !p2) return;
    if ([p1.value isEqual:p2.value]) return;
    
    if (p1.rank < p2.rank) {
        p1.parent = p2;
    } else if (p1.rank > p2.rank) {
        p2.parent = p1;
    } else {
        p1.parent = p2;
        p2.rank += 1;
    }
}

- (BOOL)isSameWithValue1:(id<NSCopying>)value1 value2:(id<NSCopying>)value2 {
    return [[self findWithValue:value1] isEqual:[self findWithValue:value2]];
}

@end

