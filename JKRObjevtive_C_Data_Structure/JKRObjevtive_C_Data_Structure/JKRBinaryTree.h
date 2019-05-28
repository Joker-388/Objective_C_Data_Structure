//
//  JKRBinaryTree.h
//  TreeDemo
//
//  Created by Joker on 2019/5/6.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JKRBinaryTreeTraversalType) {
    JKRBinaryTreeTraversalTypePreorder = 1,
    JKRBinaryTreeTraversalTypeInorder,
    JKRBinaryTreeTraversalTypePostorder,
    JKRBinaryTreeTraversalTypeLevelOrder
};

@class JKRBinaryTreeNode;

@interface JKRBinaryTree<ObjectType> : NSObject {
@protected
    NSUInteger _size;
    JKRBinaryTreeNode *_root;
}
/// 是否显示debug打印
@property (nonatomic, assign) BOOL debugPrint;

/// 节点个数
- (NSUInteger)count;
/// 二叉树是否为空
- (BOOL)isEmpty;
/// 清空二叉树
- (void)removeAllObjects;
/// 二叉树高度
- (NSUInteger)height;

/// 获取所有元素（默认中序遍历）
- (NSMutableArray<ObjectType> *)allObjects;
/// 获取所有元素（指定二叉树遍历方式）
- (NSMutableArray<ObjectType> *)allObjectsWithTraversalType:(JKRBinaryTreeTraversalType)traversalType;
/// 枚举元素（默认中序遍历）
- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, BOOL *stop))block;
/// 枚举元素（指定二叉树遍历方式）
- (void)enumerateObjectsWithTraversalType:(JKRBinaryTreeTraversalType)traversalType usingBlock:(void (^)(ObjectType obj, BOOL *stop))block;

/// 翻转二叉树 递归
- (void)invertByRecursion;
/// 翻转二叉树 迭代
- (void)invertByIteration;
/// 前驱节点
- (JKRBinaryTreeNode *)predecessorWithNode:(JKRBinaryTreeNode *)node;
/// 后继节点
- (JKRBinaryTreeNode *)successorWithNode:(JKRBinaryTreeNode *)node;
/// 创建一个节点
- (JKRBinaryTreeNode *)createNodeWithObject:(nonnull id)object parent:(nullable JKRBinaryTreeNode *)parent;
/// Log打印
- (void)printTree;
/// Print打印
- (void)debugPrintTree;


@end

NS_ASSUME_NONNULL_END
