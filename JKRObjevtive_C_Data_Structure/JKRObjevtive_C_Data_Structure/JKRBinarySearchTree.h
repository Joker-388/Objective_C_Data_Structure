//
//  JKRBinarySearchTree.h
//  TreeDemo
//
//  Created by Lucky on 2019/4/30.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

@class JKRBinaryTreeNode;

typedef NSInteger(^jkrbinarytree_compareBlock)(id e1, id e2);

@protocol JKRBinarySearchTreeCompare <NSObject>

- (NSInteger)binaryTreeCompare:(id)object;

@end

@interface JKRBinarySearchTree<ObjectType> : JKRBinaryTree {
@protected
    jkrbinarytree_compareBlock _compareBlock;
}

/*
 二叉搜索树添加的元素必须具备可比较性
 1，通过初始化方法传入比较的代码块
 2，加入的对象是系统默认的带有compare:方法的类的实例，例如：NSNumber、NSString类的实例对象
 3，加入的对象实现binaryTreeCompare:方法
 */
- (instancetype)initWithCompare:(_Nonnull jkrbinarytree_compareBlock)compare;

@property (nonatomic, strong) void(^rotateBlock)(void);

/// 添加元素
- (void)addObject:(ObjectType)object;
/// 删除元素
- (void)removeObject:(ObjectType)object;
/// 是否包含元素
- (BOOL)containsObject:(ObjectType)object;
/// 添加节点后的处理
- (void)afterAddWithNewNode:(JKRBinaryTreeNode *)node;
/// 删除节点后的处理
- (void)afterRemoveWithNode:(JKRBinaryTreeNode *)node;
/// 通过元素获取对应节点
- (JKRBinaryTreeNode *)nodeWithObject:(ObjectType)object;
/// 删除节点
- (void)removeWithNode:(JKRBinaryTreeNode *)node;
/// 左旋转一个节点
- (void)rotateLeft:(JKRBinaryTreeNode *)grand;
/// 右旋转一个节点
- (void)rotateRight:(JKRBinaryTreeNode *)grand;
/// 旋转后处理
- (void)afterRotateWithGrand:(JKRBinaryTreeNode *)grand parent:(JKRBinaryTreeNode *)parent child:(JKRBinaryTreeNode *)child;
/// 统一旋转
- (void)rotateWithRoot:(JKRBinaryTreeNode *)root
                     b:(JKRBinaryTreeNode *)b
                     c:(JKRBinaryTreeNode *)c
                     d:(JKRBinaryTreeNode *)d
                     e:(JKRBinaryTreeNode *)e
                     f:(JKRBinaryTreeNode *)f;

@end



NS_ASSUME_NONNULL_END
