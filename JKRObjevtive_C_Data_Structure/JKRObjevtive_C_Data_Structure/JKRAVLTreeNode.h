//
//  JKRAVLTreeNode.h
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinaryTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRAVLTreeNode : JKRBinaryTreeNode

/// 节点高度
@property (nonatomic, assign) NSInteger height;

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent;
/// 平衡因子
- (NSInteger)balanceFactor;
/// 更新节点高度
- (void)updateHeight;
/// 高度更高的子节点
- (JKRBinaryTreeNode *)tallerChild;

@end

NS_ASSUME_NONNULL_END
