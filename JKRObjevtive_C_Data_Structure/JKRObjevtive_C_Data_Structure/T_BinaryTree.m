//
//  T_BinaryTree.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/6/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "T_BinaryTree.h"
#import "LevelOrderPrinter.h"

@interface T_BinaryTree ()<LevelOrderPrinterDelegate>

@end

@implementation T_BinaryTree

#pragma mark - LevelOrderPrinterDelegate
/// 返回二叉树的根节点
- (id)print_root {
    return _root;
}

/// 返回一个节点对象的左子节点
- (id)print_left:(id)node {
    T_BinaryTreeNode *n = (T_BinaryTreeNode *)node;
    return n.left;
}

/// 返回一个节点对象的右子节点
- (id)print_right:(id)node {
    T_BinaryTreeNode *n = (T_BinaryTreeNode *)node;
    return n.right;
}

/// 返回一个节点输出什么样的文字
- (id)print_string:(id)node {
    return [NSString stringWithFormat:@"%@", node];
}

#pragma mark - 格式化输出
/// 重写二叉树的打印方法
- (NSString *)description {
    return [LevelOrderPrinter printStringWithTree:self];
}

@end

@implementation T_BinaryTreeNode

- (instancetype)initWithObject:(id)object parent:(T_BinaryTreeNode *)parent {
    self = [super init];
    self.object = object;
    self.parent = parent;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (p: %@)", self.object, self.parent.object];
}

@end
