//
//  JKRBinaryTreeNode.h
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRBinaryTreeNode : NSObject

@property (nonatomic, strong, nonnull) id object;
@property (nonatomic, strong, nullable) JKRBinaryTreeNode *left;
@property (nonatomic, strong, nullable) JKRBinaryTreeNode *right;
@property (nonatomic, weak, nullable) JKRBinaryTreeNode *parent;

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent;

/// 是否是叶子节点
- (BOOL)isLeaf;
/// 是否有度为2
- (BOOL)hasTwoChildren;
/// 是否是父节点的左子树
- (BOOL)isLeftChild;
/// 是否是父节点的右子树
- (BOOL)isRightChild;
/// 返回兄弟节点
- (JKRBinaryTreeNode *)sibling;

@end

NS_ASSUME_NONNULL_END
