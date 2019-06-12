//
//  T_BinarySearchTree.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/6/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "T_BinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger(^t_binarytree_compareBlock)(id e1, id e2);

@interface T_BinarySearchTree<ObjectType> : T_BinaryTree {
@protected
    t_binarytree_compareBlock _compareBlock;
}

/*
 二叉搜索树添加的元素必须具备可比较性
 1，通过初始化方法传入比较的代码块
 2，加入的对象是系统默认的带有compare:方法的类的实例，例如：NSNumber、NSString类的实例对象
 3，加入的对象实现binaryTreeCompare:方法
 */
- (instancetype)initWithCompare:(_Nullable t_binarytree_compareBlock)compare;

/// 添加元素
- (void)addObject:(nonnull ObjectType)object;
/// 删除元素
//- (void)removeObject:(nonnull ObjectType)object;
/// 是否包含元素
- (BOOL)containsObject:(nonnull ObjectType)object;
/// 通过元素获取对应节点
- (T_BinaryTreeNode *)nodeWithObject:(nonnull ObjectType)object;
/// 删除节点
//- (void)removeWithNode:(T_BinaryTreeNode *)node;

@end

NS_ASSUME_NONNULL_END
