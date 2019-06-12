//
//  T_BinarySearchTree.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/6/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "T_BinarySearchTree.h"

@implementation T_BinarySearchTree

- (instancetype)initWithCompare:(t_binarytree_compareBlock)compare {
    self = [super init];
    _compareBlock = compare;
    return self;
}

- (NSInteger)compareWithValue1:(id)value1 value2:(id)value2 {
    NSInteger result = 0;
    if (_compareBlock) { // 有比较器
        result = _compareBlock(value1, value2);
    } else if ([value1 respondsToSelector:@selector(compare:)]){ // 系统自带的可比较对象
        result = [value1 compare:value2];
    } else {
        NSAssert(NO, @"object can not compare!");
    }
    return result;
}

- (void)objectNotNullCheck:(id)object {
    if (!object) {
        NSAssert(NO, @"object must not be null!");
    }
}

- (void)addObject:(id)object {
    [self objectNotNullCheck:object];
    
    if (!_root) {
        T_BinaryTreeNode *newNode = [[T_BinaryTreeNode alloc] initWithObject:object parent:nil];
        _root = newNode;
        _size++;
        return;
    }
    
    T_BinaryTreeNode *parent = _root;
    T_BinaryTreeNode *node = _root;
    NSInteger cmp = 0;
    while (node) {
        cmp = [self compareWithValue1:object value2:node.object];
        parent = node;
        if (cmp < 0) {
            node = node.left;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node.object = object;
            return;
        }
    }
    T_BinaryTreeNode *newNode = [[T_BinaryTreeNode alloc] initWithObject:object parent:parent];;
    if (cmp < 0) {
        parent.left = newNode;
    } else {
        parent.right = newNode;
    }
    _size++;
}

- (T_BinaryTreeNode *)nodeWithObject:(id)object {
    T_BinaryTreeNode *node = _root;
    while (node) {
        NSInteger cmp = [self compareWithValue1:object value2:node.object];
        if (!cmp) {
            return node;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node = node.left;
        }
    }
    return nil;
}

- (BOOL)containsObject:(id)object {
    return [self nodeWithObject:object] != nil;
}

@end
