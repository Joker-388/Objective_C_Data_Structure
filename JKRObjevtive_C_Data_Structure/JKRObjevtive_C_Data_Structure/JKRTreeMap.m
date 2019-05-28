//
//  JKRTreeMap.m
//  TreeMapSet
//
//  Created by Lucky on 2019/5/18.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRTreeMap.h"
#import "JKRStack.h"
#import "JKRQueue.h"

@interface JKRTreeMapNode : NSObject

@property (nonatomic, assign) BOOL color;
@property (nonatomic, strong, nonnull) id key;
@property (nonatomic, strong, nonnull) id value;
@property (nonatomic, strong, nullable) JKRTreeMapNode *left;
@property (nonatomic, strong, nullable) JKRTreeMapNode *right;
@property (nonatomic, weak, nullable) JKRTreeMapNode *parent;

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRTreeMapNode *)parent;
/// 是否是叶子节点
- (BOOL)isLeaf;
/// 是否有度为2
- (BOOL)hasTwoChildren;
/// 是否是父节点的左子树
- (BOOL)isLeftChild;
/// 是否是父节点的右子树
- (BOOL)isRightChild;
/// 返回兄弟节点
- (JKRTreeMapNode *)sibling;

@end


@implementation JKRTreeMap

static BOOL const RED = false;
static BOOL const BLACK = true;

- (instancetype)initWithCompare:(jkrmap_compareBlock)compare {
    self = [super init];
    _compareBlock = compare;
    return self;
}

#pragma mark - 添加节点
- (void)setObject:(id)object forKey:(id)key {
    [self keyNotNullCheck:key];
    
    if (!_root) {
        JKRTreeMapNode *newNode = [[JKRTreeMapNode alloc] initWithKey:key value:object parent:nil];
        _root = newNode;
        _size++;
        [self afterAddWithNewNode:newNode];
        return;
    }
    
    JKRTreeMapNode *parent = _root;
    JKRTreeMapNode *node = _root;
    int cmp = 0;
    while (node) {
        cmp = [self compareWithKey1:key key2:node.key];
        parent = node;
        if (cmp < 0) {
            node = node.left;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node.value = object;
            return;
        }
    }
    
    JKRTreeMapNode *newNode = [[JKRTreeMapNode alloc] initWithKey:key value:object parent:parent];
    if (cmp < 0) {
        parent.left = newNode;
    } else {
        parent.right = newNode;
    }

    [self afterAddWithNewNode:newNode];
    _size++;
}

#pragma mark - 删除节点
- (void)removeWithNode:(JKRTreeMapNode *)node {
    if (!node) {
        return;
    }
    _size--;
    
    if (node.hasTwoChildren) {
        JKRTreeMapNode *s = [self successorWithNode:node];
        node.key = s.key;
        node.value = s.value;
        node = s;
    }
    
    // 实际被删除节点的子节点
    JKRTreeMapNode *replacement = node.left ? node.left : node.right;
    if (replacement) { // 被删除的节点度为1
        replacement.parent = node.parent;
        if (!node.parent) {
            _root = replacement;
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else {
            node.parent.right = replacement;
        }
        [self afterRemoveWithNode:replacement];
    } else if(!node.parent) { // 被删除的节点度为0且没有父节点，被删除的节点是根节点且二叉树只有一个节点
        _root = nil;
        [self afterRemoveWithNode:node];
    } else { // 被删除的节点是叶子节点且不是根节点
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {
            node.parent.right = nil;
        }
        [self afterRemoveWithNode:node];
    }
}

#pragma mark - 通过key删除元素
- (void)removeObjectForKey:(id)key {
    [self removeWithNode:[self nodeWithKey:key]];
}

#pragma mark - 清空
- (void)removeAllObjects {
    _root = nil;
    _size = 0;
}

#pragma mark - 返回元素个数
- (NSUInteger)count {
    return _size;
}

#pragma mark - 通过key获取值
- (id)objectForKey:(id)key {
    JKRTreeMapNode *node = [self nodeWithKey:key];
    return node ? node.value : nil;
}

#pragma mark - 是否包含key
- (BOOL)containsKey:(id)key {
     return [self nodeWithKey:key] != nil;
}

#pragma mark - 是否包含值
- (BOOL)containsObject:(id)object {
    if (!_root) {
        return false;
    }
    
    JKRQueue *queue = [JKRQueue new];
    [queue enQueue:_root];
    while (queue.count) {
        for (NSUInteger i = 0, n = queue.count; i < n; i++) {
            JKRTreeMapNode *n = [queue deQueue];
            if ([self comparyValueWithValue1:object value2:n.value]) return YES;
            if (n.left) {
                [queue enQueue:n.left];
            }
            if (n.right) {
                [queue enQueue:n.right];
            }
        }
    }
    return false;
}

#pragma mark - 枚举
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    if (!_root) {
        return;
    }
    
    BOOL stop = NO;
    
    JKRStack *stack = [JKRStack new];
    JKRTreeMapNode *node = _root;
    do {
        while (node) {
            [stack push:node];
            node = node.left;
        }
        if (stack.count) {
            JKRTreeMapNode *n = [stack pop];
            block(n.key, n.value, &stop);
            node = n.right;
        }
    } while((stack.count || node) && !stop);
}

#pragma mark - key比较
- (int)compareWithKey1:(id)key1 key2:(id)key2 {
    if (_compareBlock) {
        return _compareBlock(key1, key2);
    } else {
        return [key1 compare:key2];
    }
}

#pragma mark - value比较
- (BOOL)comparyValueWithValue1:(id)value1 value2:(id)value2 {
    return !value1 ? !value2 : [value1 isEqual:value2];
}



#pragma mark - 节点的后继节点
- (JKRTreeMapNode *)successorWithNode:(JKRTreeMapNode *)node {
    if (!node) {
        return nil;
    }
    
    if (node.right) {
        JKRTreeMapNode *p = node.right;
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

#pragma mark - 通过key获得节点
- (JKRTreeMapNode *)nodeWithKey:(id)key {
    JKRTreeMapNode *node = _root;
    while (node) {
        int cmp = [self compareWithKey1:key key2:node.key];
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

#pragma mark - key空判断
- (void)keyNotNullCheck:(id)key {
    if (!key) {
        NSAssert(NO, @"element must not be null");
    }
}

#pragma mark - 删除后维持平衡
- (void)afterRemoveWithNode:(JKRTreeMapNode *)node {
    // 如果删除的节点是红色，或者用以取代删除节点的子节点是红色
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    JKRTreeMapNode *parent = node.parent;
    // 删除的是根节点
    if (!parent) {
        return;
    }
    
    // 删除的是黑色叶子节点，下溢，判定被删除的节点是左还是右
    BOOL left = !parent.left || node.isLeftChild;
    JKRTreeMapNode *sibling = left ? parent.right : parent.left;
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

#pragma mark - 添加后维持平衡
- (void)afterAddWithNewNode:(JKRTreeMapNode *)node {
    JKRTreeMapNode *parent = node.parent;
    
    // 添加的节点是根节点 或者 上溢出到达根节点
    if (!parent) {
        [self black:node];
        return;
    }

    if ([self isBlack:parent]) {
        return;
    }
    
    // 叔父节点
    JKRTreeMapNode *uncle = parent.sibling;
    // 祖父节点
    JKRTreeMapNode *grand = [self red:parent.parent];
    
    
    // 叔父节点是红色的情况，B树节点上溢
    if ([self isRed:uncle]) {
        [self black:parent];
        [self black:uncle];
        // 把祖父节点当作是新添加的节点
        [self afterAddWithNewNode:grand];
        return;
    }
    
    // 叔父节点不是红色
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL
            [self black:parent];
        } else { // LR
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
        if (node.isLeftChild) { // RL
            [self black:node];
            [self rotateRight:parent];
        } else { // RR
            [self black:parent];
        }
        [self rotateLeft:grand];
    }
}

#pragma mark - 左旋转一个节点
- (void)rotateLeft:(JKRTreeMapNode *)grand {
    JKRTreeMapNode *parent = grand.right;
    JKRTreeMapNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 右旋转一个节点
- (void)rotateRight:(JKRTreeMapNode *)grand {
    JKRTreeMapNode *parent = grand.left;
    JKRTreeMapNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 旋转后处理
- (void)afterRotateWithGrand:(JKRTreeMapNode *)grand parent:(JKRTreeMapNode *)parent child:(JKRTreeMapNode *)child {
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
}

#pragma mark - 为一个节点染色
- (JKRTreeMapNode *)dyeNode:(JKRTreeMapNode *)node color:(BOOL)color {
    if (!node) {
        return node;
    }
    node.color = color;
    return node;
}

#pragma mark - 将一个节点染成红色
- (JKRTreeMapNode *)red:(JKRTreeMapNode *)node {
    return [self dyeNode:node color:RED];
}

#pragma mark - 将一个节点染成黑色
- (JKRTreeMapNode *)black:(JKRTreeMapNode *)node {
    return [self dyeNode:node color:BLACK];
}

#pragma mark - 返回节点颜色
- (BOOL)colorOf:(JKRTreeMapNode *)node {
    return !node ? BLACK : node.color;
}

#pragma mark - 节点是否为黑色
- (BOOL)isBlack:(JKRTreeMapNode *)node {
    return [self colorOf:node] == BLACK;
}

#pragma mark - 节点是否为红色
- (BOOL)isRed:(JKRTreeMapNode *)node {
    return [self colorOf:node] == RED;
}

- (void)dealloc {
//    NSLog(@"<%@: %p> dealloc", self.className, self);
}

#pragma mark - 扩展
- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj forKey:key];
}

@end

@implementation JKRTreeMapNode

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRTreeMapNode *)parent {
    self = [super init];
    self.key = key;
    self.value = value;
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

- (JKRTreeMapNode *)sibling {
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

@end
