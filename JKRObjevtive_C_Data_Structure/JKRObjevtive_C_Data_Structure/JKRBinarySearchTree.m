//
//  JKRBinarySearchTree.m
//  TreeDemo
//
//  Created by Lucky on 2019/4/30.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinarySearchTree.h"
#import "JKRBinaryTreeNode.h"

@interface JKRBinarySearchTree ()

@property (nonatomic, assign) BOOL hasInvert;

@end

@implementation JKRBinarySearchTree

- (instancetype)initWithCompare:(jkrbinarytree_compareBlock)compare {
    self = [super init];
    _compareBlock = compare;
    return self;
}

#pragma mark - 翻转后记录是否反转，用于维持翻转后的二叉搜索树能够正确的搜索节点
- (void)invertByIteration {
    [super invertByIteration];
    self.hasInvert = !self.hasInvert;
}

- (void)invertByRecursion {
    [super invertByIteration];
    self.hasInvert = !self.hasInvert;
}

#pragma mark - 添加元素
- (void)addObject:(id)object {
    if (self.debugPrint) {
        printf("添加元素: %s\n\n", [[NSString stringWithFormat:@"%@", object] UTF8String]);
    }
    [self elementNotNullCheck:object];
    
    if (!_root) {
        JKRBinaryTreeNode *newNode = [self createNodeWithObject:object parent:nil];
        _root = newNode;
        _size++;
        if(self.debugPrint) {
            printf("\n--- 平衡前 --- \n");
            [self debugPrintTree];
        }
        [self afterAddWithNewNode:newNode];
        return;
    }
    
    JKRBinaryTreeNode *parent = _root;
    JKRBinaryTreeNode *node = _root;
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
    JKRBinaryTreeNode *newNode = [self createNodeWithObject:object parent:parent];
    if (cmp < 0) {
        parent.left = newNode;
    } else {
        parent.right = newNode;
    }
    if(self.debugPrint) {
        printf("\n--- 平衡前 --- \n");
        [self debugPrintTree];
    }
    [self afterAddWithNewNode:newNode];
    _size++;
}

- (void)afterAddWithNewNode:(JKRBinaryTreeNode *)node {
    
}

- (void)elementNotNullCheck:(id)element {
    if (!element) {
        NSAssert(NO, @"object must not be null!");
    }
}

#pragma mark - 删除元素
- (void)removeObject:(id)object {
    [self removeWithNode:[self nodeWithObject:object]];
}

#pragma mark - 删除节点
- (void)removeWithNode:(JKRBinaryTreeNode *)node {
    if (!node) {
        return;
    }
    _size--;
    
    if (node.hasTwoChildren) {
        JKRBinaryTreeNode *s = [self successorWithNode:node];
        node.object = s.object;
        node = s;
    }
    
    // 实际被删除节点的子节点
    JKRBinaryTreeNode *replacement = node.left ? node.left : node.right;
    if (replacement) { // 被删除的节点度为1
        replacement.parent = node.parent;
        if (!node.parent) {
            _root = replacement;
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else {
            node.parent.right = replacement;
        }
        if(self.debugPrint) {
            printf("\n--- 平衡前 --- \n");
            [self debugPrintTree];
        }
        [self afterRemoveWithNode:replacement];
    } else if(!node.parent) { // 被删除的节点度为0且没有父节点，被删除的节点是根节点且二叉树只有一个节点
        _root = nil;
        if(self.debugPrint) {
            printf("\n--- 平衡前 --- \n");
            [self debugPrintTree];
        }
        [self afterRemoveWithNode:node];
    } else { // 被删除的节点是叶子节点且不是根节点
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {
            node.parent.right = nil;
        }
        if(self.debugPrint) {
            printf("\n--- 平衡前 --- \n");
            [self debugPrintTree];
        }
        [self afterRemoveWithNode:node];
    }
}

- (void)afterRemoveWithNode:(JKRBinaryTreeNode *)node {
    
}

#pragma mark - 是否包含元素
- (BOOL)containsObject:(id)object  {
    return [self nodeWithObject:object] != nil;
}

#pragma mark - 通过元素获取对应节点
- (JKRBinaryTreeNode *)nodeWithObject:(id)object {
    JKRBinaryTreeNode *node = _root;
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

#pragma mark - 元素比较
- (NSInteger)compareWithValue1:(id)value1 value2:(id)value2 {
    NSInteger result = 0;
    if (_compareBlock) { // 有比较器
        result = _compareBlock(value1, value2);
    } else if ([value1 respondsToSelector:@selector(binaryTreeCompare:)]) { // 实现了自定义比较方法
        result = [value1 binaryTreeCompare:value2];
    } else if ([value1 respondsToSelector:@selector(compare:)]){ // 系统自带的可比较对象
        result = [value1 compare:value2];
    } else {
        NSAssert(NO, @"object can not compare!");
    }
    return self.hasInvert ? -result : result;
}

#pragma mark - 左旋转一个节点
- (void)rotateLeft:(JKRBinaryTreeNode *)grand {
    if(self.debugPrint) {
        printf("\n--- 左旋转 --- %s \n", [[NSString stringWithFormat:@"%@", grand.object] UTF8String]);
    }
    JKRBinaryTreeNode *parent = grand.right;
    JKRBinaryTreeNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 右旋转一个节点
- (void)rotateRight:(JKRBinaryTreeNode *)grand {
    if(self.debugPrint) {
        printf("\n--- 右旋转 --- %s \n", [[NSString stringWithFormat:@"%@", grand.object] UTF8String]);        
    }
    JKRBinaryTreeNode *parent = grand.left;
    JKRBinaryTreeNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 旋转后处理
- (void)afterRotateWithGrand:(JKRBinaryTreeNode *)grand parent:(JKRBinaryTreeNode *)parent child:(JKRBinaryTreeNode *)child {
    if (grand.isLeftChild) {
        grand.parent.left = parent;
    } else if (grand.isRightChild) {
        grand.parent.right = parent;
    } else {
        _root = parent;
    }
    
    if (child) {
        child.parent = grand;
    }
    
    parent.parent = grand.parent;
    grand.parent = parent;
    if(self.debugPrint) {
        [self debugPrintTree];
    }
}

#pragma mark - 统一旋转
- (void)rotateWithRoot:(JKRBinaryTreeNode *)root
                     b:(JKRBinaryTreeNode *)b
                     c:(JKRBinaryTreeNode *)c
                     d:(JKRBinaryTreeNode *)d
                     e:(JKRBinaryTreeNode *)e
                     f:(JKRBinaryTreeNode *)f {
    d.parent = root.parent;
    if (root.isLeftChild) root.parent.left = d;
    else if (root.isRightChild) root.parent.right = d;
    else _root = d;
    
    b.right = c;
    if (c) c.parent = b;
    
    f.left = e;
    if (e) e.parent = f;
    
    d.left = b;
    d.right = f;
    b.parent = d;
    f.parent = d;
}

@end
