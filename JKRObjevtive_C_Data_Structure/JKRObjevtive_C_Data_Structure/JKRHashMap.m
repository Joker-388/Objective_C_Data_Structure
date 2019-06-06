//
//  JKRHashMap.m
//  HashMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRHashMap.h"
#import "Person.h"
#import "JKRArray.h"
#import "NSObject+JKRDataStructure.h"
#import "LevelOrderPrinter.h"
#import "JKRQueue.h"

#define HASH_MAP_COLOR_RED false
#define HASH_MAP_COLOR_BLACK true
#define HASH_MAP_DEAFULT_CAPACITY (1<<4)
#define HASH_MAP_LOAD_FACTOR 0.75f

@interface JKRHashMapNode : NSObject

@property (nonatomic, assign) BOOL color;
@property (nonatomic, strong, nonnull) id key;
@property (nonatomic, strong, nonnull) id value;
@property (nonatomic, assign) NSUInteger keyHashCode;
@property (nonatomic, strong, nullable) JKRHashMapNode *left;
@property (nonatomic, strong, nullable) JKRHashMapNode *right;
@property (nonatomic, weak, nullable) JKRHashMapNode *parent;

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRHashMapNode *)parent;

@end

@interface JKRHashTempTree : NSObject<LevelOrderPrinterDelegate>

@property (nonatomic, strong) JKRHashMapNode *root;
- (instancetype)initWithRoot:(JKRHashMapNode *)root;

@end

@interface JKRHashMap ()

@property (nonatomic, strong) JKRArray *array;

@end

@implementation JKRHashMap

- (instancetype)init {
    self = [super init];
    self.array = [JKRArray arrayWithLength:HASH_MAP_DEAFULT_CAPACITY];
    return self;
}

- (void)removeAllObjects {
    if (_size == 0) return;
    _size = 0;
    for (NSUInteger i = 0; i < self.array.length; i++) {
        self.array[i] = nil;
    }
}

- (id)objectForKey:(id)key {
    JKRHashMapNode *node = [self nodeWithKey:key];
    return node ? node.value : nil;
}

- (BOOL)containsKey:(id)key {
    return [self nodeWithKey:key] != nil;
}

- (BOOL)containsObject:(id)object {
    if (_size == 0) return NO;
    JKRQueue *queue = [JKRQueue new];
    for (NSUInteger i = 0; i < self.array.length; i++) {
        if (self.array[i] == nil) continue;
        [queue enQueue:self.array[i]];
        while (queue.count) {
            JKRHashMapNode *node = queue.deQueue;
            if (object == node.value || [object isEqual:node.value]) return YES;
            if (node.left) [queue enQueue:node.left];
            if (node.right) [queue enQueue:node.right];
        }
    }
    return NO;
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    if (_size == 0) return;
    BOOL stop = NO;
    JKRQueue *queue = [JKRQueue new];
    for (NSUInteger i = 0; i < self.array.length && !stop; i++) {
        if (self.array[i] == nil) continue;
        [queue enQueue:self.array[i]];
        while (queue.count && !stop) {
            JKRHashMapNode *node = queue.deQueue;
            block(node.key, node.value, &stop);
            if (node.left) [queue enQueue:node.left];
            if (node.right) [queue enQueue:node.right];
        }
    }
}

- (void)removeObjectForKey:(id)key {
    [self removeWithNode:[self nodeWithKey:key]];
}

- (NSUInteger)count {
    return _size;
}

#pragma mark - 添加节点
- (void)setObject:(id)object forKey:(id)key {
    [self resize];
    
    NSUInteger index = jkrHashMap_indexWithKey(key, self.array);
    JKRHashMapNode *root = self.array[index];
    if (!root) {
        root = [[JKRHashMapNode alloc] initWithKey:key value:object parent:nil];
        self.array[index] = root;
        _size++;
        [self afterAddWithNewNode:root];
        return;
    }
    
    JKRHashMapNode *parent = root;
    JKRHashMapNode *node = root;
    NSInteger cmp = 0;
    id k1 = key;
    NSUInteger h1 = jkrHaspMap_hash(k1);
    JKRHashMapNode *result = nil;
    BOOL searched = false;
    
    do {
        parent = node;
        id k2 = node.key;
        NSUInteger h2 = node.hash;
        if (h1 > h2) {
            cmp = 1;
        } else if (h1 < h2) {
            cmp = -1;
        } else if (k1 == k2 || [k1 isEqual:k2]) {
            cmp = 0;
        } else if (k1 && k2 && [k1 class] == [k2 class] && [k1 respondsToSelector:@selector(compare:)] && (cmp = [k1 compare:k2])) {
        } else if (searched) {
            cmp = [k1 jkr_addressIdentity] - [k2 jkr_addressIdentity];
        } else {
            if ((node.left && (result = [self nodeWithNode:node.left key:k1])) || (node.right && (result = [self nodeWithNode:node.right key:k1]))) {
                node = result;
                cmp = 0;
            } else {
                searched = true;
                cmp = [k1 jkr_addressIdentity] - [k2 jkr_addressIdentity];
            }
        }
        
        if (cmp < 0) {
            node = node.left;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node.key = key;
            node.value = object;
            return;
        }
    } while (node);
    
    JKRHashMapNode *newNode = [[JKRHashMapNode alloc] initWithKey:key value:object parent:parent];
    if (cmp < 0) parent.left = newNode;
    else parent.right = newNode;
    _size++;
    [self afterAddWithNewNode:newNode];
}

#pragma mark - 删除节点
- (void)removeWithNode:(JKRHashMapNode *)node {
    if (!node) return;
    
    _size--;
    if (node.left && node.right) {
        JKRHashMapNode *s = jkrHashMap_successor(node);
        node.key = s.key;
        node.value = s.value;
        node.keyHashCode = s.keyHashCode;
        node = s;
    }
    
    // 实际被删除节点的子节点
    JKRHashMapNode *replacement = node.left ? node.left : node.right;
    NSUInteger index = jkrHashMap_indexWithNode(node, self.array);
    if (replacement) { // 被删除的节点度为1
        replacement.parent = node.parent;
        if (!node.parent) {
            self.array[index] = replacement;
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else {
            node.parent.right = replacement;
        }
        [self afterRemoveWithNode:replacement];
    } else if(!node.parent) { // 被删除的节点度为0且没有父节点，被删除的节点是根节点且二叉树只有一个节点
        self.array[index] = nil;
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

#pragma mark - 扩容
- (void)resize {
    if (_size <= self.array.length * HASH_MAP_LOAD_FACTOR) return;
    
    JKRArray *oldArray = self.array;
    self.array = [JKRArray arrayWithLength:oldArray.length << 1];
    JKRQueue *queue = [JKRQueue new];
    for (NSUInteger i = 0; i < oldArray.length; i++) {
        if (!oldArray[i]) continue;
        
        [queue enQueue:oldArray[i]];
        while (queue.count) {
            JKRHashMapNode *node = [queue deQueue];
            if (node.left) [queue enQueue:node.left];
            if (node.right) [queue enQueue:node.right];
            [self moveNode:node];
        }
    }
}

- (void)moveNode:(JKRHashMapNode *)newNode {
    newNode.parent = nil;
    newNode.left = nil;
    newNode.right = nil;
    newNode.color = HASH_MAP_COLOR_RED;
    
    NSUInteger index = jkrHashMap_indexWithNode(newNode, self.array);
    JKRHashMapNode *root = self.array[index];
    if (!root) {
        root = newNode;
        self.array[index] = root;
        [self afterAddWithNewNode:root];
        return;
    }
    
    JKRHashMapNode *parent = root;
    JKRHashMapNode *node = root;
    NSInteger cmp = 0;
    id k1 = newNode.key;
    NSUInteger h1 = newNode.hash;
    do {
        parent = node;
        id k2 = node.key;
        NSUInteger h2 = node.hash;
        if (h1 > h2) {
            cmp = 1;
        } else if (h1 < h2) {
            cmp = -1;
        } else if (k1 && k2 && [k1 class] == [k2 class] && [k1 respondsToSelector:@selector(compare:)] && (cmp = [k1 compare:k2])) {
        } else {
            cmp = [k1 jkr_addressIdentity] - [k2 jkr_addressIdentity];
        }
        if (cmp > 0) node = node.right;
        else if (cmp < 0) node = node.left;
    } while (node);
    
    newNode.parent = parent;
    if (cmp > 0) parent.right = newNode;
    else parent.left = newNode;
    [self afterAddWithNewNode:newNode];
}

#pragma mark - 平衡红黑树
- (void)afterRemoveWithNode:(JKRHashMapNode *)node {
    // 如果删除的节点是红色，或者用以取代删除节点的子节点是红色
    if (jkrHashMap_isRed(node)) {
        node.color = HASH_MAP_COLOR_BLACK;
        return;
    }
    
    JKRHashMapNode *parent = node.parent;

    if (!parent) return;
    
    // 删除的是黑色叶子节点，下溢，判定被删除的节点是左还是右
    BOOL left = !parent.left || (node.parent && node.parent.left == node);
    JKRHashMapNode *sibling = left ? parent.right : parent.left;
    if (left) { // 被删除的节点在左边，兄弟节点在右边
        if (jkrHashMap_isRed(sibling)) { // 兄弟节点是红色
            sibling.color = HASH_MAP_COLOR_BLACK;
            parent.color = HASH_MAP_COLOR_RED;
            [self rotateLeft:parent];
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 兄弟节点必然是黑色
        if (jkrHashMap_isBlack(sibling.left) && jkrHashMap_isBlack(sibling.right)) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = jkrHashMap_isBlack(parent);
            parent.color = HASH_MAP_COLOR_BLACK;
            sibling.color = HASH_MAP_COLOR_RED;
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if (jkrHashMap_isBlack(sibling.right)) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            sibling.color = jkrHashMap_color(parent);
            sibling.right.color = HASH_MAP_COLOR_BLACK;
            parent.color = HASH_MAP_COLOR_BLACK;
            [self rotateLeft:parent];
        }
    } else { // 被删除的节点在右边，兄弟节点在左边
        if (jkrHashMap_isRed(sibling)) { // 兄弟节点是红色
            sibling.color = HASH_MAP_COLOR_BLACK;
            parent.color = HASH_MAP_COLOR_RED;
            [self rotateRight:parent];
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 兄弟节点必然是黑色
        if (jkrHashMap_isBlack(sibling.left) && jkrHashMap_isBlack(sibling.right)) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = jkrHashMap_isBlack(parent);
            parent.color = HASH_MAP_COLOR_BLACK;
            sibling.color = HASH_MAP_COLOR_RED;
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if (jkrHashMap_isBlack(sibling.left)) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            sibling.color = jkrHashMap_color(parent);
            sibling.left.color = HASH_MAP_COLOR_BLACK;
            parent.color = HASH_MAP_COLOR_BLACK;
            [self rotateRight:parent];
        }
    }
}

- (void)afterAddWithNewNode:(JKRHashMapNode *)node {
    JKRHashMapNode *parent = node.parent;
    
    // 添加的节点是根节点 或者 上溢出到达根节点
    if (!parent) {
        node.color = HASH_MAP_COLOR_BLACK;
        return;
    }
    
    if (jkrHashMap_isBlack(parent)) return;
    
    // 叔父节点
    JKRHashMapNode *uncle = nil;
    if (parent.parent) {
        if (parent.parent.left == parent) {
            uncle = parent.parent.right;
        }
        if (parent.parent.right == parent) {
            uncle = parent.parent.left;
        }
    }
    // 祖父节点
    parent.parent.color = HASH_MAP_COLOR_RED;
    JKRHashMapNode *grand = parent.parent;
    
    // 叔父节点是红色的情况，B树节点上溢
    if (jkrHashMap_isRed(uncle)) {
        parent.color = HASH_MAP_COLOR_BLACK;
        uncle.color = HASH_MAP_COLOR_BLACK;
        // 把祖父节点当作是新添加的节点
        [self afterAddWithNewNode:grand];
        return;
    }
    
    // 叔父节点不是红色
    if (parent.parent && parent.parent.left == parent) { // L
        if (node.parent && node.parent.left == node) { // LL
            parent.color = HASH_MAP_COLOR_BLACK;
        } else { // LR
            node.color = HASH_MAP_COLOR_BLACK;
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
        if (node.parent && node.parent.left == node) { // RL
            node.color = HASH_MAP_COLOR_BLACK;
            [self rotateRight:parent];
        } else { // RR
            parent.color = HASH_MAP_COLOR_BLACK;
        }
        [self rotateLeft:grand];
    }
}

- (void)rotateLeft:(JKRHashMapNode *)grand {
    JKRHashMapNode *parent = grand.right;
    JKRHashMapNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    jkrHashMap_afterRotate(grand, parent, child, self.array);
}

- (void)rotateRight:(JKRHashMapNode *)grand {
    JKRHashMapNode *parent = grand.left;
    JKRHashMapNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    jkrHashMap_afterRotate(grand, parent, child, self.array);
}

static inline void jkrHashMap_afterRotate(JKRHashMapNode *grand, JKRHashMapNode *parent, JKRHashMapNode *child, JKRArray *array) {
    if (grand.parent && grand.parent.left == grand) {
        grand.parent.left = parent;
    } else if (grand.parent && grand.parent.right == grand) {
        grand.parent.right = parent;
    } else {
        NSUInteger index = jkrHashMap_indexWithNode(grand, array);
        array[index] = parent;
    }
    
    if (child) child.parent = grand;
    
    parent.parent = grand.parent;
    grand.parent = parent;
}

static inline JKRHashMapNode * jkrHashMap_successor(JKRHashMapNode *node) {
    if (!node) return nil;
    
    if (node.right) {
        JKRHashMapNode *p = node.right;
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

static inline BOOL jkrHashMap_color(JKRHashMapNode *node) {
    return !node ? HASH_MAP_COLOR_BLACK : node.color;
}

static inline BOOL jkrHashMap_isBlack(JKRHashMapNode *node) {
    BOOL color = !node ? HASH_MAP_COLOR_BLACK : node.color;
    return color == HASH_MAP_COLOR_BLACK;
}

static inline BOOL jkrHashMap_isRed(JKRHashMapNode *node) {
    BOOL color = !node ? HASH_MAP_COLOR_BLACK : node.color;
    return color == HASH_MAP_COLOR_RED;
}

#pragma mark - 获取哈希表index
static inline NSUInteger jkrHashMap_indexWithKey(id key, JKRArray *array) {
    return jkrHaspMap_hash(key) & (array.length - 1);
}

static inline NSUInteger jkrHashMap_indexWithNode(JKRHashMapNode *node, JKRArray *array) {
    return node.hash & (array.length - 1);
}

static inline NSUInteger jkrHaspMap_hash(id key) {
    if (!key) return 0;
    NSUInteger hash = [key hash];
    return (hash ^ (hash >> 16));
}

#pragma mark - 获取哈希表节点
- (JKRHashMapNode *)nodeWithKey:(id)key {
    NSUInteger index = jkrHashMap_indexWithKey(key, self.array);
    JKRHashMapNode *root = self.array[index];
    return root ? [self nodeWithNode:root key:key] : nil;
}

- (JKRHashMapNode *)nodeWithNode:(JKRHashMapNode *)node key:(id)key {
    NSUInteger hash1 = jkrHaspMap_hash(key);
    JKRHashMapNode *result = nil;
    NSInteger cmp = 0;
    while (node) {
        id key2 = node.key;
        NSUInteger hash2 = node.hash;
        if (hash1 > hash2) {
            node = node.right;
        } else if (hash1 < hash2) {
            node = node.left;
        } else if (key == key2 || [key isEqual:key2]) {
            return node;
        } else if (key && key2 && [key class] == [key2 class] && [key respondsToSelector:@selector(compare:)] && (cmp = [key compare:key2])) {
            node = cmp > 0 ? node.right : node.left;
        } else if (node.right && (result = [self nodeWithNode:node.right key:key])) {
            return result;
        } else {
            node = node.left;
        }
    }
    return nil;
}

#pragma mark - 运算符重载
- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj forKey:key];
}

#pragma mark - 打印
- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"<%@, %p>: \ncount:%zd length:%zd\n{\n", self.className, self, _size, self.array.length]];
    [self.array enumerateObjectsUsingBlock:^(JKRHashMapNode*  _Nullable node, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendString:[NSString stringWithFormat:@"\n--- index: %zd ---\n", idx]];
        if (node) {
            JKRHashTempTree *tree = [[JKRHashTempTree alloc] initWithRoot:node];
            [string appendString:[LevelOrderPrinter printStringWithTree:tree]];
        } else {
            [string appendString:@"   "];
            [string appendString:@"Null"];
        }
    }];
    [string appendString:@"\n}"];
    return string;
}

- (void)dealloc {
//    NSLog(@"<%@, %p>: dealloc", self.className, self);
}

@end

@interface JKRHashMapNode ()

@end

@implementation JKRHashMapNode

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRHashMapNode *)parent {
    self = [super init];
    self.key = key;
    self.value = value;
    self.parent = parent;
    NSUInteger hash = key ? [key hash] : 0;
    self.keyHashCode = hash ^ (hash >> 16);
    return self;
}

- (NSUInteger)hash {
    return _keyHashCode;
}

- (void)dealloc {
    //    NSLog(@"<%@: %p> dealloc", self.className, self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@: %@", self.color ? @"":@"R_", self.key, self.value];
}

@end

@implementation JKRHashTempTree

- (instancetype)initWithRoot:(JKRHashMapNode *)root {
    self = [super init];
    self.root = root;
    return self;
}

- (id)print_root {
    return self.root;
}

- (id)print_left:(id)node {
    return ((JKRHashMapNode *)node).left;
}

- (id)print_right:(id)node {
    return ((JKRHashMapNode *)node).right;
}

- (id)print_string:(id)node {
    return [NSString stringWithFormat:@"%@", node];
}

@end

