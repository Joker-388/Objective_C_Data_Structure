//
//  JKRRedBlackTree
//  TreeDemo
//
//  Created by Joker on 2019/5/16.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinarySearchTree.h"

#define RBT_Color_RED false
#define RBT_Color_BLACK true

NS_ASSUME_NONNULL_BEGIN

@interface JKRRedBlackTree<ObjectType> : JKRBinarySearchTree<ObjectType>

@end

@interface JKRRedBlackTreeNode : JKRBinaryTreeNode

@property (nonatomic, assign) BOOL color;

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent;

@end

NS_ASSUME_NONNULL_END
