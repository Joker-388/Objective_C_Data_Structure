//
//  RedBlackTree.m
//  TreeDemo
//
//  Created by Joker on 2019/5/16.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRRedBlackTree.h"

@implementation JKRRedBlackTree

#pragma mark - 红黑树的性质
/*
 1，节点 是 RED 或 BLACK
 2，根节点是 BLACK
 3，叶子节点（虚拟外部节点，并非真实的叶子节点）都是BLACK
           ┌-------40------┐
           │               │
       ┌---13---┐      ┌--43--┐
       │        │    null    null
     ┌-R_2-┐   null
   null   null
 4，RED节点的子节点都是黑色
    RED节点的parent都是BALCK
    从根节点到叶子节点的所有路径上不能有2个连续的RED节点
 5，从任一节点到叶子节点的所有路径都包含相同数目的BLACK节点
 */

#pragma mark - 添加一个新节点后平衡二叉树
// 默认新添加的节点是红色节点
/*
 添加时旋转的复杂度: O(logn)，仅需O(1)次旋转操作
 */
- (void)afterAddWithNewNode:(JKRBinaryTreeNode *)node {
    JKRBinaryTreeNode *parent = node.parent;
    
    // 添加的节点是根节点 或者 上溢出到达根节点
    if (!parent) {
        if (self.debugPrint) {
            printf("\n--- 操作节点 %s 是根节点，或者上溢到达根节点---  \n\n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
            printf("\n--- 染黑节点 --- %s \n\n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
        }
        [self black:node];
        return;
    }
    
    // 如果新添加节点的父节点是黑色节点，直接添加一个红色节点就可以，不需要恢复红黑树性质
    if ([self isBlack:parent]) {
        if (self.debugPrint) {
            printf("\n--- 操作节点 %s 父节点是黑色 --- \n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
            printf("\n--- 不需要平衡 --- %s \n\n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
        }
        return;
    }
    
    // 叔父节点
    JKRBinaryTreeNode *uncle = parent.sibling;
    // 祖父节点
    JKRBinaryTreeNode *grand = [self red:parent.parent];
    
    
    // 叔父节点是红色的情况，B树节点上溢
    if ([self isRed:uncle]) {
        if(self.debugPrint) {
            printf("\n--- 操作节点 %s 叔父节点是红色 --- \n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
            printf("\n--- 染红 grand --- %s \n\n", [[NSString stringWithFormat:@"%@", grand] UTF8String]);
            printf("\n--- 染黑 parent --- %s \n\n", [[NSString stringWithFormat:@"%@", parent] UTF8String]);
            printf("\n--- 染黑 uncle --- %s \n\n", [[NSString stringWithFormat:@"%@", uncle] UTF8String]);
        }
       
        [self black:parent];
        [self black:uncle];
        if(self.debugPrint) {
            [self debugPrintTree];
        }
        // 把祖父节点当作是新添加的节点
        [self afterAddWithNewNode:grand];
        return;
    }
    
    // 叔父节点不是红色
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL
            if(self.debugPrint) {
                printf("\n--- 操作节点 %s 叔父节点不是红色 LL --- \n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
                printf("\n--- 染红 grand --- %s \n\n", [[NSString stringWithFormat:@"%@", grand] UTF8String]);
                printf("\n--- 染黑 parent --- %s \n\n", [[NSString stringWithFormat:@"%@", parent] UTF8String]);
            }
            [self black:parent];
        } else { // LR
            if(self.debugPrint) {
                printf("\n--- 操作节点 %s 叔父节点不是红色 LR --- \n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
                printf("\n--- 染红 grand --- %s \n\n", [[NSString stringWithFormat:@"%@", grand] UTF8String]);
                printf("\n--- 染黑节点 --- %s \n\n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
            }
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
        if (node.isLeftChild) { // RL
            if(self.debugPrint) {
                printf("\n--- 操作节点 %s 叔父节点不是红色 RL --- \n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
                printf("\n--- 染红 grand --- %s \n\n", [[NSString stringWithFormat:@"%@", grand] UTF8String]);
                printf("\n--- 染黑节点 --- %s \n\n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
            }
            [self black:node];
            [self rotateRight:parent];
        } else { // RR
            if(self.debugPrint) {
                printf("\n--- 操作节点 %s 叔父节点不是红色 RR --- \n", [[NSString stringWithFormat:@"%@", node] UTF8String]);
                printf("\n--- 染红 grand --- %s \n\n", [[NSString stringWithFormat:@"%@", grand] UTF8String]);
                printf("\n--- 染黑 parent --- %s \n\n", [[NSString stringWithFormat:@"%@", parent] UTF8String]);
            }
            [self black:parent];
        }
        [self rotateLeft:grand];
    }
}

#pragma mark - 删除一个节点后平衡二叉树
/*
 删除时旋转的复杂度: O(logn)，最多需要O(1)次旋转
 经统计，红黑树的溢出递归次数很少，可以看成O(1)
 */
- (void)afterRemoveWithNode:(JKRBinaryTreeNode *)node {
    // 如果删除的节点是红色，或者用以取代删除节点的子节点是红色
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    JKRBinaryTreeNode *parent = node.parent;
    // 删除的是根节点
    if (!parent) {
        return;
    }
    
    // 删除的是黑色叶子节点，下溢，判定被删除的节点是左还是右
    BOOL left = !parent.left || node.isLeftChild;
    JKRBinaryTreeNode *sibling = left ? parent.right : parent.left;
    if (left) { // 被删除的节点在左边，兄弟节点在右边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling.right]) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            [self dyeNode:sibling color:[self colorOf:parent]];
            [self black:sibling.right];
            [self black:parent];
            [self rotateLeft:parent];
        }
    } else { // 被删除的节点在右边，兄弟节点在左边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling.left]) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            [self dyeNode:sibling color:[self colorOf:parent]];
            [self black:sibling.left];
            [self black:parent];
            [self rotateRight:parent];
        }
    }
}

#pragma mark - 为一个节点染色
- (JKRBinaryTreeNode *)dyeNode:(JKRBinaryTreeNode *)node color:(BOOL)color {
    if (!node) {
        return node;
    }
    ((JKRRedBlackTreeNode *) node).color = color;
    return node;
}

#pragma mark - 将一个节点染成红色
- (JKRBinaryTreeNode *)red:(JKRBinaryTreeNode *)node {
    return [self dyeNode:node color:RBT_Color_RED];
}

#pragma mark - 将一个节点染成黑色
- (JKRBinaryTreeNode *)black:(JKRBinaryTreeNode *)node {
    return [self dyeNode:node color:RBT_Color_BLACK];
}

#pragma mark - 返回节点颜色
- (BOOL)colorOf:(JKRBinaryTreeNode *)node {
    return !node ? RBT_Color_BLACK : ((JKRRedBlackTreeNode *)node).color;
}

#pragma mark - 节点是否为黑色
- (BOOL)isBlack:(JKRBinaryTreeNode *)node {
    return [self colorOf:node] == RBT_Color_BLACK;
}

#pragma mark - 节点是否为红色
- (BOOL)isRed:(JKRBinaryTreeNode *)node {
    return [self colorOf:node] == RBT_Color_RED;
}

#pragma mark - 创建一个红黑节点
- (JKRBinaryTreeNode *)createNodeWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    return [[JKRRedBlackTreeNode alloc] initWithObject:object parent:parent];
}

@end

@implementation JKRRedBlackTreeNode

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    self = [super init];
    self.object = object;
    self.parent = parent;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@", self.color == RBT_Color_RED ? @"R_" : @"", self.object];
}

@end
