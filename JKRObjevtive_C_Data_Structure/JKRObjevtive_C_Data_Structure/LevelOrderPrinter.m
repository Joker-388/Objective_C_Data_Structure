//
//  LevelOrderPrinter.m
//  TreeDemo
//
//  Created by Lucky on 2019/5/1.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "LevelOrderPrinter.h"

/// 二叉树节点左右横向线的最小长度
#define TOP_LINE_SPACE 1
/// 二叉树节点之间的最小距离
#define MIN_SPACE 1

@implementation PrintNode

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    [self _initWithString:string];
    return self;
}

- (instancetype)initWithBtNode:(id)btNode tree:(id<LevelOrderPrinterDelegate>)tree {
    self = [super init];
    [self _initWithString:[[tree print_string:btNode] description]];
    self.btNode = btNode;
    return self;
}

- (void)_initWithString:(NSString *)string {
    string = string ?  string : @"null";
    string = string.length == 0 ? @" " : string;
    self.width = (int)string.length;
    self.string = string;
}

- (void)balanceWithLeft:(PrintNode *)left right:(PrintNode *)right {
    if (!left || !right) return;
    
    int deltaLeft = self.x - [self.left rightX];
    int deltaRight = self.right.x - [self rightX];
    
    int delta= MAX(deltaLeft, deltaRight);
    int newRightX = [self rightX] + delta;
    [right translateX:(newRightX - right.x)];
    
    int newLeftX = self.x - delta - left.width;
    [left translateX:(newLeftX - left.x)];
}

- (int)rightX {
    return self.x + self.width;
}

- (void)translateX:(int)deltaX {
    if (deltaX == 0) return;
    
    self.x += deltaX;
    if (!self.btNode) return;
    
    if (self.left) [self.left translateX:deltaX];
    if (self.right) [self.right translateX:deltaX];
}

/// 顶部方向字符的X值
- (int)topLineX {
    int delta = self.width;
    if (delta % 2 == 0) delta--;
    delta >>= 1;
    
    if (self.parent && self.parent.left == self) return [self rightX] - 1 - delta;
    else return self.x + delta;
}

/// 右边界的位置
- (int)rightBound {
    if (!self.right) return [self rightX];
    return [self.right topLineX] + 1;
}

/// 左边界的位置
- (int)leftBound {
    if (!self.left) return self.x;
    return [self.left topLineX];
}

/// 左边界之间的长度
- (int)leftBoundLength {
    return self.x - [self leftBound];
}

/// 右边界之间的长度
- (int)rightBoundLength {
    return [self rightBound] - [self rightX];
}

/// 左边界可以清空的长度
- (int)leftBoundEmptyLength {
    return [self leftBoundLength] - 1 - TOP_LINE_SPACE;
}

/// 左边界可以清空的长度
- (int)rightBoundEmptyLength {
    return [self rightBoundLength] - 1 - TOP_LINE_SPACE;
}

- (int)treeHeigh:(PrintNode *)node {
    if (!node) return 0;
    if (node.treeHeight != 0) return node.treeHeight;
    
    node.treeHeight = 1 + MAX([self treeHeigh:node.left], [self treeHeigh:node.right]);
    return node.treeHeight;
}

/// 和右节点之间的最小层级距离
- (int)minLevelSpaceToRight:(PrintNode *)right {
    int thisHeight = [self treeHeigh:self];
    int rightHeight = [self treeHeigh:right];
    int minSpace = INT_MAX;
    for (int i = 0; i < thisHeight && i < rightHeight; i++) {
        int space = [right levelInfo:i].leftX - [self levelInfo:i].rightX;
        minSpace = MIN(minSpace, space);
    }
    return minSpace;;
}

- (LevelInfo *)levelInfo:(int)level {
    if (level < 0) return nil;
    int levelY = self.y + level;
    if (level >= [self treeHeigh:self]) return nil;
    
    NSMutableArray<PrintNode *> *list = [NSMutableArray array];
    NSMutableArray<PrintNode *> *queue = [NSMutableArray array];
    [queue addObject:self];
    while (queue.count) {
        PrintNode *node = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        if (levelY == node.y) [list addObject:node];
        else if (node.y > levelY) break;
        
        if (node.left) [queue addObject:node.left];
        if (node.right) [queue addObject:node.right];
    }
    
    PrintNode *left = list[0];
    PrintNode *right = list.lastObject;
    return [[LevelInfo alloc] initWithLeft:left right:right];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>: string: %@, x: %d, y: %d, treeHeight: %d, Width: %d", self.className, self, self.string, self.x, self.y, self.treeHeight, self.width];
}

@end


@implementation LevelInfo

- (instancetype)initWithLeft:(PrintNode *)left right:(PrintNode *)right {
    self = [super init];
    self.leftX = [left leftBound];
    self.rightX = [right rightBound];
    return self;
}

@end

@interface LevelOrderPrinter ()

@property (nonatomic, strong) PrintNode *root;
@property (nonatomic, assign) int minX;
// 所有节点的宽度最大值
@property (nonatomic, assign) int maxWidth;

@end

@implementation LevelOrderPrinter

+ (void)printTree:(id<LevelOrderPrinterDelegate>)tree {
    LevelOrderPrinter *printer = [[LevelOrderPrinter alloc] initWithTree:tree];
    [printer print];
}

+ (NSString *)printStringWithTree:(id<LevelOrderPrinterDelegate>)tree {
    LevelOrderPrinter *printer = [[LevelOrderPrinter alloc] initWithTree:tree];
    return [printer printString];
}

- (instancetype)initWithTree:(id<LevelOrderPrinterDelegate>)tree {
    self = [super init];
    self.tree = tree;
    self.root = [[PrintNode alloc] initWithBtNode:tree.print_root tree:tree];
    self.maxWidth = self.root.width;
    return self;
}

#pragma mark - 二叉树格式化字符串
- (NSString *)printString {
    // 要打印的节点，二维数组，存储每一行: 每一行要打印的节点，要打印的节点用PrintNode对象表示（包括元素节点和连线符号）
    NSMutableArray <NSMutableArray<PrintNode *> *> *nodes = [NSMutableArray array];
    // 将二叉树填充成满二叉树，用空元素填充，用于下一步计算每一个节点的坐标
    [self fillNodes:nodes];
    // 计算节点的坐标，清除上一步用于填充的空元素节点
    [self cleanNodes:nodes];
    // 压缩多余的空格
    [self compressNodes:nodes];
    // 添加连线，更新x坐标
    [self addLineNodes:nodes];
    
    int rowCont = (int)nodes.count;
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString appendString:@"\n"];
    for (int i = 0; i < rowCont; i++) {
        if (i != 0) [mutableString appendString:@"\n"];
        
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        NSMutableString *rowMutableSting = [NSMutableString string];
        for (PrintNode *node in rowNodes) {
            int leftSpace = (int)(node.x - rowMutableSting.length - self.minX);
            for (int i = 0; i < leftSpace; i++) [rowMutableSting appendString:@" "];
            [rowMutableSting appendString:node.string];
        }
        
        [mutableString appendString:rowMutableSting];
    }
    
    return mutableString;
}

#pragma mark - 添加打印节点
- (PrintNode *)addNodeWithNodes:(NSMutableArray<PrintNode *> *)nodes btNode:(id)btNode {
    if (btNode) {
        PrintNode *node = [[PrintNode alloc] initWithBtNode:btNode tree:self.tree];
        self.maxWidth = MAX(self.maxWidth, node.width);
        [nodes addObject:node];
        return node;
    } else {
        NSNull *null = [NSNull new];
        [nodes addObject:(PrintNode *)null];
        return (PrintNode *)null;
    }
}

#pragma mark - 将二叉树填充成满二叉树
- (void)fillNodes:(NSMutableArray <NSMutableArray<PrintNode *> *> *)nodes  {
    if (!nodes) return;
    NSMutableArray<PrintNode *> *firstRowNodes = [NSMutableArray array];
    [firstRowNodes addObject:self.root];
    [nodes addObject:firstRowNodes];
    
    while (true) {
        NSMutableArray<PrintNode *> *preRowNodes = [nodes objectAtIndex:nodes.count - 1];
        NSMutableArray<PrintNode *> *rowNodes = [NSMutableArray array];
        BOOL notNull = false;
        for (PrintNode *node in preRowNodes) {
            if ([node isEqual:[NSNull null]]) {
                [rowNodes addObject:(PrintNode *)[NSNull new]];
                [rowNodes addObject:(PrintNode *)[NSNull new]];
            } else {
                PrintNode *left = [self addNodeWithNodes:rowNodes btNode:[self.tree print_left:node.btNode]];
                if (![left isEqual:[NSNull null]]) {
                    node.left = left;
                    left.parent = node;
                    notNull = true;
                }
                PrintNode *right = [self addNodeWithNodes:rowNodes btNode:[self.tree print_right:node.btNode]];
                if (![right isEqual:[NSNull null]]) {
                    node.right = right;
                    right.parent = node;
                    notNull = true;
                }
            }
        }
        if (!notNull) break;
        
        [nodes addObject:rowNodes];
    }
}

#pragma mark - 计算节点的坐标
- (void)cleanNodes:(NSMutableArray <NSMutableArray<PrintNode *> *> *)nodes {
    if (!nodes) return;
    int rowCount = (int)nodes.count;
    // rowCount小于2即只有一行节点，只有根节点，这种情况不需要处理
    if (rowCount < 2) return;
    // 最后一行节点的个数
    int lastRowNodeCount = (int)nodes[rowCount - 1].count;
    // 节点的间距
    int nodeSpace = self.maxWidth + 2;
    // 最后一行的长度
    int lastRowLength = lastRowNodeCount * self.maxWidth + nodeSpace * (lastRowNodeCount - 1);
    for (int i = 0; i < rowCount; i++) {
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        // 当前行要打印节点的个数
        int rowNodeCount = (int)rowNodes.count;
        // 节点左右两边的间距
        int allSpace = lastRowLength - (rowNodeCount - 1) * nodeSpace;
        int cornerSpace = allSpace / rowNodeCount - self.maxWidth;
        cornerSpace >>= 1;
        int rowLength = 0;
        for (int j = 0; j < rowNodeCount; j++) {
            if (j != 0) {
                // 每个节点之间的间距
                rowLength += nodeSpace;
            }
            rowLength += cornerSpace;
            PrintNode *node = rowNodes[j];
            if (![node isEqual:[NSNull null]]) {
                // 居中
                int deltaX = (self.maxWidth - node.width) >> 1;
                node.x = rowLength + deltaX;
                node.y = i;
            }
            rowLength += self.maxWidth;
            rowLength += cornerSpace;
        }
        // 移除所有空节点
        NSMutableArray *removeRows = [NSMutableArray array];
        for (int m = 0; m < rowNodes.count; m++) {
            if ([rowNodes[m] isEqual:[NSNull null]]) [removeRows addObject:rowNodes[m]];
        }
        [rowNodes removeObjectsInArray:removeRows];
    }
}

#pragma mark - 压缩多余的空格
- (void)compressNodes:(NSMutableArray <NSMutableArray<PrintNode *> *> *)nodes {
    if (!nodes) return;
    int rowCount = (int)nodes.count;
    if (rowCount < 2) return;
    
    for (int i = rowCount - 2; i >= 0; i--) {
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        for (PrintNode *node in rowNodes) {
            PrintNode *left = node.left;
            PrintNode *right = node.right;
            if (!left && !right) continue;
            
            if (left && right) {
                [node balanceWithLeft:left right:right];
                
                int leftEmpty = [node leftBoundEmptyLength];
                int rightEmpty = [node rightBoundEmptyLength];
                int empty = MIN(leftEmpty, rightEmpty);
                empty = MIN(empty, (right.x - [left rightX])>> 1);
                
                int space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                space = MIN(space >> 1, empty);
                
                if (space > 0) {
                    [left translateX:space];
                    [right translateX:-space];
                }
                space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                if (space < 1) continue;
                
                leftEmpty = [node leftBoundEmptyLength];
                rightEmpty = [node rightBoundEmptyLength];
                if (leftEmpty < 1 && rightEmpty < 1) continue;
                
                if (leftEmpty > rightEmpty) [left translateX:MIN(leftEmpty, space)];
                else [right translateX:(-MIN(rightEmpty, space))];
            } else if (left) {
                [left translateX:[node leftBoundEmptyLength]];
            } else {
                [right translateX:(-[node rightBoundEmptyLength])];
            }
        }
    }
}

#pragma mark - 添加连线
- (void)addLineNodes:(NSMutableArray<NSMutableArray<PrintNode *> *> *)nodes {
    NSMutableArray<NSMutableArray<PrintNode *> *> *newNodes = [NSMutableArray array];
    int rowCount = (int)nodes.count;
    if (rowCount < 2) return;
    
    self.minX = self.root.x;
    
    for (int i = 0; i < rowCount; i++) {
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        if (i == rowCount - 1) {
            [newNodes addObject:rowNodes];
            continue;
        }
        
        NSMutableArray<PrintNode *> *newRowNodes = [NSMutableArray array];
        [newNodes addObject:newRowNodes];
        
        NSMutableArray<PrintNode *> *lineNodes = [NSMutableArray array];
        [newNodes addObject:lineNodes];
        
        for (PrintNode *node in rowNodes) {
            [self addLineNode:newRowNodes nextRow:lineNodes parent:node child:node.left];
            [newRowNodes addObject:node];
            [self addLineNode:newRowNodes nextRow:lineNodes parent:node child:node.right];
        }
    }
    
    [nodes removeAllObjects];
    [nodes addObjectsFromArray:newNodes];
}

- (void)addXLineNode:(NSMutableArray<PrintNode *> *)curRow parent:(PrintNode *)parent x:(int)x {
    PrintNode *line = [[PrintNode alloc] initWithString:@"-"];
    line.x = x;
    line.y = parent.y;
    [curRow addObject:line];
}

- (PrintNode *)addLineNode:(NSMutableArray<PrintNode *> *)curRow nextRow:(NSMutableArray<PrintNode *> *)nextRow parent:(PrintNode *)parent child:(PrintNode *)child {
    if (!child) return nil;
    
    PrintNode *top = nil;
    int topX = [child topLineX];
    if (child == parent.left) {
        top = [[PrintNode alloc] initWithString:@"┌"];
        [curRow addObject:top];
        for (int x = topX + 1; x < parent.x; x++) [self addXLineNode:curRow parent:parent x:x];
    } else {
        for (int x = [parent rightX]; x < topX; x++) [self addXLineNode:curRow parent:parent x:x];
        top = [[PrintNode alloc] initWithString:@"┐"];
        [curRow addObject:top];
    }
    
    top.x = topX;
    top.y = parent.y;
    child.y = parent.y + 2;
    self.minX = MIN(self.minX, child.x);
    
    PrintNode *bottom = [[PrintNode alloc] initWithString:@"│"];
    bottom.x = topX;
    bottom.y = parent.y + 1;
    [nextRow addObject:bottom];
    
    return top;
}

#pragma mark - 打印二叉树
- (void)print {
    NSLog(@"%@", [self printString]);
}

//- (void)dealloc {
//    NSLog(@"<%@: %p> dealloc", self.className, self);
//}

@end
