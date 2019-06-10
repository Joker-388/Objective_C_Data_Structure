//
//  JKRBinaryTree.m
//  TreeDemo
//
//  Created by Joker on 2019/5/6.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinaryTree.h"
#import "LevelOrderPrinter.h"
#import "JKRQueue.h"
#import "JKRStack.h"

typedef void(^orderBlock)(id element);

@interface JKRBinaryTree ()<LevelOrderPrinterDelegate>

@end

@implementation JKRBinaryTree

#pragma mark - 节点个数
- (NSUInteger)count {
    return _size;
}

#pragma mark - 二叉树是否为空
- (BOOL)isEmpty {
    return _size == 0;
}

#pragma mark - 清空二叉树
- (void)removeAllObjects {
    _root = nil;
    _size = 0;
}

#pragma mark - 二叉树高度
- (NSUInteger)height {
    NSUInteger height = 0;
    if (_root) {
        JKRQueue *queue = [JKRQueue new];
        [queue enQueue:_root];
        while (queue.count) {
            height++;
            for (NSInteger i = 0, n = queue.count; i < n; i++) {
                JKRBinaryTreeNode *node = [queue deQueue];
                if (node.left) [queue enQueue:node.left];
                if (node.right) [queue enQueue:node.right];
            }
        }
    }
    return height;
}



#pragma mark - 获取所有元素（默认中序遍历）
- (NSMutableArray *)allObjects {
    return [self inorderTraversal];
}

#pragma mark -获取所有元素（指定二叉树遍历方式）
- (NSMutableArray *)allObjectsWithTraversalType:(JKRBinaryTreeTraversalType)traversalType {
    switch (traversalType) {
        case JKRBinaryTreeTraversalTypePreorder:
            return [self preorderTraversal];
            break;
        case JKRBinaryTreeTraversalTypeInorder:
            return [self inorderTraversal];
            break;
        case JKRBinaryTreeTraversalTypePostorder:
            return [self postorderTraversal];
            break;
        case JKRBinaryTreeTraversalTypeLevelOrder:
            return [self levelOrderTraversal];
            break;
        default:
            return [self inorderTraversal];
            break;
    }
}

#pragma mark - 枚举元素（默认中序遍历）
- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    [self enumerateObjectsWithInorderTraversalUsingBlock:block];
}

#pragma mark - 枚举元素（指定二叉树遍历方式）
- (void)enumerateObjectsWithTraversalType:(JKRBinaryTreeTraversalType)traversalType usingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    switch (traversalType) {
        case JKRBinaryTreeTraversalTypePreorder:
            [self enumerateObjectsWithPreorderTraversalUsingBlock:block];
            break;
        case JKRBinaryTreeTraversalTypeInorder:
            [self enumerateObjectsWithInorderTraversalUsingBlock:block];
            break;
        case JKRBinaryTreeTraversalTypePostorder:
            [self enumerateObjectsWithPostorderTraversalUsingBlock:block];
            break;
        case JKRBinaryTreeTraversalTypeLevelOrder:
            [self enumerateObjectsWithLevelOrderTraversalUsingBlock:block];
            break;
        default:
            [self enumerateObjectsWithInorderTraversalUsingBlock:block];
            break;
    }
}

#pragma mark - 前序遍历
/*
 非自平衡的二叉搜索树，前序遍历会按照添加节点的顺序输出，AVL树、红黑树则不是
 */
- (NSMutableArray *)preorderTraversal {
    __block BOOL stop = NO;
    
    NSMutableArray *elements = [NSMutableArray array];
    [self preorderTraversalWithBlock:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
    
//    NSMutableArray *elements = [NSMutableArray array];
//    [self preorderTraversal:_root block:^(id element) {
//        [elements addObject:element];
//    } stop:&stop];
//    return elements;
}

- (void)enumerateObjectsWithPreorderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    
    [self  preorderTraversalWithBlock:^(id element) {
        block(element, &stop);
    } stop:&stop];
    
//    [self preorderTraversal:_root block:^(id element) {
//        block(element, &stop);
//    } stop:&stop];
}

- (void)preorderTraversalWithBlock:(orderBlock)block stop:(BOOL *)stop {
    if (_root) {
        JKRStack *stack = [JKRStack new];
        [stack push:_root];
        while (stack.count && !*stop) {
            JKRBinaryTreeNode *n = [stack pop];
            block(n.object);
            if (n.right) {
                [stack push:n.right];
            }
            if (n.left) {
                [stack push:n.left];
            }
        }
    }
}

- (void)preorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
    if (node && !*stop) {
        block(node.object);
        [self preorderTraversal:node.left block:block stop:stop];
        [self preorderTraversal:node.right block:block stop:stop];
    }
}

#pragma mark - 后序遍历
- (NSMutableArray *)postorderTraversal {
    __block BOOL stop = NO;
    
    NSMutableArray *elements = [NSMutableArray array];
    [self postorderTraversalWithBlock:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
    
//    NSMutableArray *elements = [NSMutableArray array];
//    [self postorderTraversal:_root block:^(id element) {
//        [elements addObject:element];
//    } stop:&stop];
//    return elements;
}

- (void)enumerateObjectsWithPostorderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    
    [self postorderTraversalWithBlock:^(id element) {
        block(element, &stop);
    } stop:&stop];
    
//    [self postorderTraversal:_root block:^(id element) {
//        block(element, &stop);
//    } stop:&stop];
}

- (void)postorderTraversalWithBlock:(orderBlock)block stop:(BOOL *)stop {
    if (!_root) return;
    JKRStack *stack = [JKRStack new];
    [stack push:_root];
    JKRBinaryTreeNode *prevPopNode;
    while (stack.count && !*stop) {
        JKRBinaryTreeNode *top = stack.peek;
        if (top.isLeaf || (prevPopNode && prevPopNode.parent == top)) {
            prevPopNode = stack.pop;
            block(prevPopNode.object);
        } else {
            if (top.right) [stack push:top.right];
            if (top.left) [stack push:top.left];
        }
    }
}

- (void)postorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
    if (node && !*stop) {
        [self postorderTraversal:node.left block:block stop:stop];
        [self postorderTraversal:node.right block:block stop:stop];
        if (*stop) return;
        block(node.object);
    }
}

#pragma mark - 中序遍历
/*
 二叉搜索树中序遍历，会按照定义的比较规则升序或者降序输出
 */
- (NSMutableArray *)inorderTraversal {
    __block BOOL stop = NO;
    
    NSMutableArray *elements = [NSMutableArray array];
    [self inorderTraversalWithBlock:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
    
//    NSMutableArray *elements = [NSMutableArray array];
//    [self inorderTraversal:_root block:^(id element) {
//        [elements addObject:element];
//    } stop:&stop];
//    return elements;
}

- (void)enumerateObjectsWithInorderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    
    [self inorderTraversalWithBlock:^(id element) {
        block(element, &stop);
    } stop:&stop];
    
//    [self inorderTraversal:_root block:^(id element) {
//        block(element, &stop);
//    } stop:&stop];
}

- (void)inorderTraversalWithBlock:(orderBlock)block stop:(BOOL *)stop {
    if (!_root) return;
    JKRBinaryTreeNode *node = _root;
    JKRStack *stack = [JKRStack new];
    do {
        while (node) {
            [stack push:node];
            node = node.left;
        }
        if (stack.count) {
            JKRBinaryTreeNode *n = [stack pop];
            block(n.object);
            node = n.right;
        }
    } while((stack.count || node) && !*stop);
}

- (void)inorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
    if (node && !*stop) {
        [self inorderTraversal:node.left block:block stop:stop];
        if (*stop) return;
        block(node.object);
        [self inorderTraversal:node.right block:block stop:stop];
    }
}

#pragma mark - 层序遍历
- (NSMutableArray *)levelOrderTraversal {
    __block BOOL stop = NO;
    NSMutableArray *elements = [NSMutableArray array];
    [self levelOrderTraversalWithBlock:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
}

- (void)enumerateObjectsWithLevelOrderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    [self levelOrderTraversalWithBlock:^(id element) {
        block(element, &stop);
    } stop:&stop];
}

- (void)levelOrderTraversalWithBlock:(orderBlock)block stop:(BOOL *)stop {
    if (!_root) return;
    JKRQueue *queue = [JKRQueue new];
    [queue enQueue:_root];
    while (queue.count && !*stop) {
        for (NSInteger i = 0, n = queue.count; i < n; i++) {
            if (*stop) return;
            JKRBinaryTreeNode *n = [queue deQueue];
            block(n.object);
            if (n.left) [queue enQueue:n.left];
            if (n.right) [queue enQueue:n.right];
        }
    }
}

#pragma mark - 翻转二叉树
- (void)invertByRecursion {
    [self invertByRecursion:_root];
}

- (void)invertByIteration {
    [self invertByIteration:_root];
}

- (void)invertByRecursion:(JKRBinaryTreeNode *)root {
    if (root) {
        JKRBinaryTreeNode *tmp = root.left;
        root.left = root.right;
        root.right = tmp;
        [self invertByRecursion:root.left];
        [self invertByRecursion:root.right];
    }
}

- (void)invertByIteration:(JKRBinaryTreeNode *)root {
    if (root) {
        JKRQueue *queue = [JKRQueue new];
        [queue enQueue:root];
        while (queue.count) {
            for (NSInteger i = 0, n = queue.count; i < n; i++) {
                JKRBinaryTreeNode *node = [queue deQueue];
                JKRBinaryTreeNode *tmp = node.left;
                node.left = node.right;
                node.right = tmp;
                if (node.left) [queue enQueue:node.left];
                if (node.right) [queue enQueue:node.right];
            }
        }
    }
}

#pragma mark - 节点的前驱节点
- (JKRBinaryTreeNode *)predecessorWithNode:(JKRBinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    // 节点有左子树的情况下，前驱节点在它的左子树中
    if (node.left) {
        // 前驱节点是 node.left.right.right...
        JKRBinaryTreeNode *p = node.left;
        while (p.right) {
            p = p.right;
        }
        return p;
    }
    // 节点没有左子树的情况下，如果有父节点，在父节点往上找
    while (node.parent && node == node.parent.left) {
        node = node.parent;
    }
    
    // 没有左子树，也没有父节点，就没有前驱节点
    // !node.left && (!node.parent || node == node.parent.right)
    return node.parent;
}

#pragma mark - 节点的后继节点
- (JKRBinaryTreeNode *)successorWithNode:(JKRBinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    
    if (node.right) {
        JKRBinaryTreeNode *p = node.right;
        while (p.left) {
            p = p.left;
        }
        return p;
    }
    
    while (node.parent && node == node.parent.right) {
        node = node.parent;
    }
    
    return node.parent;
}

#pragma mark - LevelOrderPrinterDelegate
- (id)print_root {
    return _root;
}

- (id)print_left:(id)node {
    JKRBinaryTreeNode *n = (JKRBinaryTreeNode *)node;
    return n.left;
}

- (id)print_right:(id)node {
    JKRBinaryTreeNode *n = (JKRBinaryTreeNode *)node;
    return n.right;
}

- (id)print_string:(id)node {
    return [NSString stringWithFormat:@"%@", node];
}

#pragma mark - 创建节点
- (JKRBinaryTreeNode *)createNodeWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    return [[JKRBinaryTreeNode alloc] initWithObject:object parent:parent];
}

#pragma mark - dealloc
- (void)dealloc {
//    NSLog(@"<%@: %p> dealloc", self.className, self);
}

#pragma mark - 格式化输出
- (NSString *)description {
    return [LevelOrderPrinter printStringWithTree:self];
}

- (void)printTree {
    NSLog(@"%@", self);
}

- (void)debugPrintTree {
    printf("\n%s\n\n", [self.description UTF8String]);
    printf("-------------------------------------------------------------------\n\n");
}

@end


@implementation JKRBinaryTreeNode

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    self = [super init];
    self.object = object;
    self.parent = parent;
    return self;
}

- (BOOL)isLeaf {
    return !self.left && !self.right;
}

- (BOOL)hasTwoChildren {
    return self.left && self.right;
}

- (BOOL)isLeftChild {
    return self.parent && self.parent.left == self;
}

- (BOOL)isRightChild {
    return self.parent && self.parent.right == self;
}

- (JKRBinaryTreeNode *)sibling {
    if ([self isLeftChild]) {
        return self.parent.right;
    }
    if ([self isRightChild]) {
        return self.parent.left;
    }
    return nil;
}

- (void)dealloc {
    //    NSLog(@"<%@: %p> dealloc", self.className, self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (p: %@)", self.object, self.parent.object];
}

@end
