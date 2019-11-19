//
//  main.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRBaseList.h"
#import "JKRArrayList.h"
#import "Person.h"
#import "JKRSingleLinkedList.h"
#import "JKRSingleCircleLinkedList.h"
#import "JKRLinkedList.h"
#import "JKRLinkedCircleList.h"
#import "JKRStack.h"
#import "JKRQueue.h"
#import "JKRBinarySearchTree.h"
#import "JKRAVLTree.h"
#import "JKRRedBlackTree.h"
#import "JKRTimeTool.h"
#import "JKRHashMap_RedBlackTree.h"
#import "JKRHashMap_LinkedList.h"
#import "JKRHashSet.h"
#import "JKRTreeMap.h"
#import "JKRTreeSet.h"
#import "JKRBinaryHeap.h"
#import "JKRArray.h"


#import "SortTest.h"
#import "UnionFindTest.h"
#import "JKRGraphTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[JKRGraphTest new] test];
    }
    return 0;
}

NSString * getRandomStr() {
    char data[6];
    for (int i = 0; i < 6; i++) data[i] = (char)((i ? 'a' : 'A') + (arc4random_uniform(26)));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    return string;
}


void check(BOOL pass, NSString *errorString) {
    if (!pass) {
        NSLog(@"!!! 发现错误 !!! :%@", errorString);
    }
}

void testBinarySearchTree() {
    JKRBinarySearchTree<NSNumber *> *tree = [[JKRBinarySearchTree alloc] initWithCompare:^NSInteger(NSNumber *  _Nonnull e1, NSNumber *  _Nonnull e2) {
        return e1.intValue - e2.intValue;
    }];
    
    int nums[] = {7,4,2,1,3,5,9,8,11,10,12};
    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [numbers addObject:[NSNumber numberWithInt:nums[i]]];
    }
    printf("\n");
    
    for (NSNumber *number in numbers) {
        [tree addObject:number];
    }
    
    /// 打印二叉树
    NSLog(@"\n-------- 原二叉树 --------");
    [tree printTree];
    
    //    NSLog(@"\n-------- 递归翻转 --------");
    //    [tree invertByRecursion];
    //    [tree printTree];
    //
    //    NSLog(@"\n前序 %@", tree.preorderTraversal);
    //
    //    /// 后序 1 3 2 5 4 8 10 12 11 9 7
    //    NSLog(@"\n后序 %@", tree.postorderTraversal);
    //
    //    /// 中序 1 2 3 4 5 7 8 9 10 11 12
    //    NSLog(@"\n中序 %@", tree.inorderTraversal);
    //
    //    /// 层序
    //    NSLog(@"\n层序 %@", tree.levelOrderTraversal);
    //
    //    NSLog(@"\n-------- 迭代翻转 --------");
    //    [tree invertByIteration];
    //    [tree printTree];
    
    
    check(tree.height == 4, @"二叉树高度计算错误");
    check(tree.count == 11, @"二叉树节点个数计算错误");
    

    JKRArrayList *checkArray = [JKRArrayList array];
    /// 前序 7 4 2 1 3 5 9 8 11 10 12
    check([[tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypePreorder] isEqual:@[@7, @4, @2, @1, @3, @5, @9, @8, @11, @10, @12]], @"前序遍历错误");
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypePreorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@9]) {
            *stop = YES;
        }
        [checkArray addObject:obj];
    }];
    check([checkArray isEqual:@[@7, @4, @2, @1, @3, @5, @9]], @"前序遍历错误");
    [checkArray removeAllObjects];
    
    /// 后序 1 3 2 5 4 8 10 12 11 9 7
    check([[tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypePostorder] isEqual:@[@1, @3, @2, @5, @4, @8, @10, @12, @11, @9, @7]], @"后序遍历错误");
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypePostorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        [checkArray addObject:obj];
    }];
    check([checkArray isEqual:@[@1, @3, @2, @5, @4]], @"后序遍历错误");
    [checkArray removeAllObjects];
    
    /// 中序 1 2 3 4 5 7 8 9 10 11 12
    check([[tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypeInorder] isEqual:@[@1, @2, @3, @4, @5, @7, @8, @9, @10, @11, @12]], @"中序遍历错误");
    
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypeInorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@5]) {
            *stop = YES;
        }
        [checkArray addObject:obj];
    }];
    check([checkArray isEqual:@[@1, @2, @3, @4, @5]], @"中序遍历错误");
    [checkArray removeAllObjects];
    
    /// 层序 7 4 9 2 5 8 11 1 3 10 12
    check([[tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypeLevelOrder] isEqual:@[@7, @4, @9, @2, @5, @8, @11, @1, @3, @10, @12]], @"层序遍历错误");
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypeLevelOrder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@11]) {
            *stop = YES;
        }
        [checkArray addObject:obj];
    }];
    check([checkArray isEqual:@[@7, @4, @9, @2, @5, @8, @11]], @"层序遍历错误");
    [checkArray removeAllObjects];
    
    /// 清空
    [tree removeAllObjects];
}

void testAVLTree() {
    JKRBinarySearchTree<NSNumber *> *avl = [JKRAVLTree new];
    avl.debugPrint = YES;
    
    int nums[] = {26, 32, 27, 38, 4, 9, 37, 45, 3, 6, 13, 2, 43, 40, 25, 46, 23, 10, 41, 11, 1, 24};
    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [numbers addObject:[NSNumber numberWithInt:nums[i]]];
    }
    
    for (NSNumber *number in numbers) {
        [avl addObject:number];
        printf("--- 平衡后结果 ---\n%s\n\n", [avl.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
}

void testRedBlackTree() {
    JKRBinarySearchTree<Person *> *rb = [[JKRRedBlackTree alloc] initWithCompare:^NSInteger(Person *  _Nonnull e1, Person *  _Nonnull e2) {
        return e1.age - e2.age;
    }];
    rb.debugPrint = YES;
    int nums[] = {55,38,80,25,46,76,88,17,33,50,72,74};
    
    NSMutableArray *persons = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [persons addObject:[Person personWithAge:nums[i]]];
    }
    printf("\n-------------------------------------------------------------------\n\n\n");
    
    for (Person *person in persons) {
        printf("Add: %zd\n\n", person.age);
        [rb addObject:person];
        printf("--- 最终平衡后结果 ---\n%s\n\n", [rb.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
    
    for (Person *person in persons) {
        printf("Remove: %zd\n\n", person.age);
        [rb removeObject:person];
        printf("--- 最终平衡后结果 ---\n%s\n\n", [rb.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
}

void compareTrees() {
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 10000; i++) {
        //        [data addObject:getRandomStr()];
        [data addObject:[NSNumber numberWithInteger:i]];
    }
    
    @autoreleasepool {
        [JKRTimeTool teskCodeWithBlock:^{
            JKRBinarySearchTree *tree = [JKRBinarySearchTree new];
            for (int i = 0; i < data.count; i++) {
                [tree addObject:data[i]];
            }
            for (int i = 0; i < data.count; i++) {
                [tree removeObject:data[i]];
            }
            NSLog(@"二叉搜索树顺序添加和删除10000条数据");
        }];
    }
    
    @autoreleasepool {
        [JKRTimeTool teskCodeWithBlock:^{
            JKRBinarySearchTree *tree = [JKRAVLTree new];
            for (int i = 0; i < data.count; i++) {
                [tree addObject:data[i]];
            }
            for (int i = 0; i < data.count; i++) {
                [tree removeObject:data[i]];
            }
            NSLog(@"AVL树顺序添加和删除10000条数据");
        }];
    }
    
    @autoreleasepool {
        [JKRTimeTool teskCodeWithBlock:^{
            JKRBinarySearchTree *tree = [JKRRedBlackTree new];
            for (int i = 0; i < data.count; i++) {
                [tree addObject:data[i]];
            }
            for (int i = 0; i < data.count; i++) {
                [tree removeObject:data[i]];
            }
            NSLog(@"红黑树顺序添加和删除10000条数据");
        }];
    }
    
}


NSMutableArray * allFileStrings() {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileManagerError;
    NSString *fileDirectory = @"/Users/joker/Documents/Objective_C_Data_Structure/JKRObjevtive_C_Data_Structure/Resource/runtime";
    
    NSArray<NSString *> *array = [fileManager subpathsOfDirectoryAtPath:fileDirectory error:&fileManagerError];
    if (fileManagerError) {
        NSLog(@"读取文件夹失败");
        nil;
    }
    NSLog(@"文件路径: %@", fileDirectory);
    NSLog(@"文件个数: %zd", array.count);
    NSMutableArray *allStrings = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filePath = [fileDirectory stringByAppendingPathComponent:obj];
        NSError *fileReadError;
        NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&fileReadError];
        if (fileReadError) {
            return;
        }
        [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            [allStrings addObject:substring];
        }];
    }];
    NSLog(@"所有单词的数量: %zd", allStrings.count);
    return allStrings;
}

void compareHashMap() {
    NSMutableArray *allStrings = allFileStrings();
    
    __block NSUInteger hashMap_lindedlist_count = 0;
    __block NSUInteger hashMap_lindedlist_all = 0;
    
    __block NSUInteger hashMap_redblacktree_count = 0;
    __block NSUInteger hashMap_redblacktree_all = 0;
    
    __block NSUInteger nsmutabledictionary_count = 0;
    __block NSUInteger nsmutabledictionary_all = 0;
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashMap_LinkedList *map = [JKRHashMap_LinkedList new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        
        hashMap_lindedlist_count = map.count;
        
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            hashMap_lindedlist_all += [map[obj] integerValue];
            [map removeObjectForKey:obj];
        }];
        
        check(map.count == 0, @"JKRHashMap_LinkedList 清空失败");
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashMap_RedBlackTree *map = [JKRHashMap_RedBlackTree new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        
        hashMap_redblacktree_count = map.count;
        
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            hashMap_redblacktree_all += [map[obj] integerValue];
            [map removeObjectForKey:obj];
        }];
        
        check(map.count == 0, @"JKRHashMap_RedBlackTree 清空失败");
    }];
 
    [JKRTimeTool teskCodeWithBlock:^{
        NSMutableDictionary *map = [NSMutableDictionary new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        nsmutabledictionary_count = map.count;
        
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            nsmutabledictionary_all += [map[obj] integerValue];
            [map removeObjectForKey:obj];
        }];
        
        check(map.count == 0, @"NSMutableDictionary 清空失败");
    }];
    
    
    check(hashMap_lindedlist_count == hashMap_redblacktree_count && hashMap_redblacktree_count == nsmutabledictionary_count && hashMap_lindedlist_all == hashMap_redblacktree_all && hashMap_redblacktree_all == nsmutabledictionary_all, @"计算不重复单词数量结果不一致！");
}

void testBinaryHeap() {
    [JKRTimeTool teskCodeWithBlock:^{
        NSMutableArray *array = [NSMutableArray array];
        for (NSUInteger i = 10; i < 1000000; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        JKRBaseHeap<NSNumber *> *heap = [[JKRBinaryHeap alloc] initWithArray:array];
        NSLog(@"批量建堆求最大值: %@", heap.top);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseHeap<NSNumber *> *heap = [[JKRBinaryHeap alloc] init];
        for (NSUInteger i = 10; i < 1000000; i++) {
            [heap addObject:[NSNumber numberWithInteger:i]];
        }
        NSLog(@"依次添加到二叉堆求最大值: %@", heap.top);
    }];
    
    /*
     批量建堆求最大值: 999999
     耗时: 0.439 s
     依次添加到二叉堆求最大值: 999999
     耗时: 3.724 s
     */
}

void testTopN() {
    NSMutableArray *allStrings = allFileStrings();
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashMap_RedBlackTree *map = [JKRHashMap_RedBlackTree new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        NSLog(@"JKRHashMap 计算不重复单词数量和出现次数 %zd", map.count);
        
        JKRBinaryHeap *heap = [[JKRBinaryHeap alloc] initWithCompare:^NSInteger(NSDictionary *  _Nonnull e1, NSDictionary *  _Nonnull e2) {
            return [e2[@"value"] compare:e1[@"value"]];
        }];
        
        // 时间复杂度 nlog(10)
        [map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (heap.count < 10) {
                [heap addObject:@{
                                  @"key": key,
                                  @"value": obj
                                  }];
            } else if ([obj compare:heap.top[@"value"]] > 0) {
                [heap replaceTop:@{
                                   @"key": key,
                                   @"value": obj
                                   }];
            }
        }];

        NSLog(@"求所有单词中，出现频率最高的10个单词");
        NSMutableArray *result = [NSMutableArray array];
        while (heap.count) {
            [result addObject:[NSString stringWithFormat:@"%@: %@", heap.top[@"key"], heap.top[@"value"]]];
            [heap removeTop];
        }
        NSLog(@"%@", result);
    }];
}

void testArray() {
    JKRArray *array = [JKRArray arrayWithLength:6];
    NSLog(@"%@", array);
    
    array[2] = [Person new];
    NSLog(@"%@", array);
    
    array[2] = nil;
    NSLog(@"%@", array);
}

void testDynamicArray() {
    JKRArrayList *array = [JKRArrayList new];
    for (NSUInteger i = 0; i < 3; i++) {
        [array insertObject:[Person personWithAge:i] atIndex:0];
    }
    NSLog(@"添加后 %@", array);
    
    array[1] = nil;
    NSLog(@"%@", array);
    
    [array removeAllObjects];
    NSLog(@"清空后 %@", array);
}

void compareArrayListAndSingleLinkedList() {
//    [JKRTimeTool teskCodeWithBlock:^{
//        JKRBaseList *array = [JKRArrayList new];
//        for (NSUInteger i = 0; i < 10000; i++) {
//            [array insertObject:[NSNumber numberWithInteger:0] atIndex:0];
//         }
//        for (NSUInteger i = 0; i < 10000; i++) {
//            [array removeFirstObject];
//        }
//        NSLog(@"动态数组");
//    }];
//    [JKRTimeTool teskCodeWithBlock:^{
//        JKRBaseList *array = [JKRSingleLinkedList new];
//        for (NSUInteger i = 0; i < 10000; i++) {
//            [array insertObject:[NSNumber numberWithInteger:0] atIndex:0];
//        }
//        for (NSUInteger i = 0; i < 10000; i++) {
//            [array removeFirstObject];
//        }
//        NSLog(@"单向链表");
//    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRArrayList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array addObject:[NSNumber numberWithInteger:0]];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeLastObject];
        }
        NSLog(@"动态数组");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array addObject:[NSNumber numberWithInteger:0]];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeLastObject];
        }
        NSLog(@"单向链表");
    }];
}

void compareSingleLinkedListAndSingleCircleLinkedList() {
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:0];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeFirstObject];
        }
        NSLog(@"单向链表操作头节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleCircleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:0];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeFirstObject];
        }
        NSLog(@"单向循环链表操作头节点");
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeLastObject];
        }
        NSLog(@"单向链表操作尾节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleCircleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeLastObject];
        }
        NSLog(@"单向循环链表操作尾节点");
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 1];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeObjectAtIndex:array.count >> 1];
        }
        NSLog(@"单向链表操作中间节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleCircleLinkedList new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 1];
        }
        for (NSUInteger i = 0; i < 10000; i++) {
            [array removeObjectAtIndex:array.count >> 1];
        }
        NSLog(@"单向循环链表操作中间节点");
    }];
}

void testSingleCirleList() {
    JKRBaseList *list = [JKRSingleCircleLinkedList new];
    [list addObject:[Person personWithAge:1]];
    NSLog(@"Add 1 \n%@", list);
    [list addObject:[Person personWithAge:3]];
    NSLog(@"Add 3 \n%@", list);
    [list insertObject:[Person personWithAge:2] atIndex:1];
    NSLog(@"Insert 2 atIndex 1 \n%@", list);
    [list insertObject:[Person personWithAge:0] atIndex:0];
    NSLog(@"Insert 0 atIndex 0 \n%@", list);
    [list removeFirstObject];
    NSLog(@"Remove first \n%@", list);
    [list removeLastObject];
    NSLog(@"Remove last \n%@", list);
    [list addObject:[Person personWithAge:3]];
    NSLog(@"Add 3 \n%@", list);
    [list removeObjectAtIndex:1];
    NSLog(@"Remove atIndex 1 \n%@", list);
    [list removeAllObjects];
    NSLog(@"Remove all \n%@", list);
}

void useSingleCircleList() {
    JKRSingleCircleLinkedList *list = [JKRSingleCircleLinkedList new];
    for (NSUInteger i = 1; i <= 41; i++) {
        [list addObject:[Person personWithAge:i]];
    }
    NSLog(@"%@", list);
    
    JKRSingleLinkedListNode *node = list->_first;
    while (list.count) {
        node = node.next;
        node = node.next;
        printf("%s ", [[NSString stringWithFormat:@"%@", node.object] UTF8String]);
        [list removeObject:node.object];
        node = node.next;
    }
    printf("\n");
}

void testLinkedList() {
    JKRBaseList *list = [JKRLinkedList new];
    [list addObject:[Person personWithAge:1]];
    printf("%s", [NSString stringWithFormat:@"添加链表第一个节点 \n%@\n\n", list].UTF8String);
    
    [list addObject:[Person personWithAge:3]];
    printf("%s", [NSString stringWithFormat:@"尾部追加一个节点 \n%@\n\n", list].UTF8String);
    
    [list insertObject:[Person personWithAge:2] atIndex:1];
    printf("%s", [NSString stringWithFormat:@"插入到链表两个节点之间 \n%@\n\n", list].UTF8String);
    
    [list insertObject:[Person personWithAge:0] atIndex:0];
    printf("%s", [NSString stringWithFormat:@"插入到链表头部 \n%@\n\n", list].UTF8String);
    
    [list removeFirstObject];
    printf("%s", [NSString stringWithFormat:@"删除头节点 \n%@\n\n", list].UTF8String);
    
    [list removeObjectAtIndex:1];
    printf("%s", [NSString stringWithFormat:@"删除链表两个节点之间的节点 \n%@\n\n", list].UTF8String);
    
    [list removeLastObject];
    printf("%s", [NSString stringWithFormat:@"删除尾节点 \n%@\n\n", list].UTF8String);
    
    [list removeAllObjects];
    printf("%s", [NSString stringWithFormat:@"删除链表唯一的节点 \n%@\n\n", list].UTF8String);
}

void compareSingleLinkedListAndLinkedList() {
    NSUInteger testCount = 10000;

    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:0];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeFirstObject];
        }
        NSLog(@"单向链表操作头节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:0];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeFirstObject];
        }
        NSLog(@"双向链表操作头节点");
    }];


    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeLastObject];
        }
        NSLog(@"单向链表操作尾节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeLastObject];
        }
        NSLog(@"双向链表操作尾节点");
    }];


    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 2];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 2];
        }
        NSLog(@"单向链表操作 index = 总节点数*0.25 节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 2];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 2];
        }
        NSLog(@"双向链表操作 index = 总节点数*0.25 节点");
    }];


    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count * 0.75];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count * 0.75];
        }
        NSLog(@"单向链表操作 index = 总节点数*0.75 节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count * 0.75];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count * 0.75];
        }
        NSLog(@"双向链表操作 index = 总节点数*0.75 节点");
    }];
    
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRSingleLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 1];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 1];
        }
        NSLog(@"单向链表操作中间节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 1];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 1];
        }
        NSLog(@"双向链表操作中间节点");
    }];
}

void testCirleList() {
    JKRBaseList *list = [JKRLinkedCircleList new];
    [list addObject:[Person personWithAge:1]];
    printf("%s", [NSString stringWithFormat:@"添加链表第一个节点 \n%@\n\n", list].UTF8String);
    
    [list addObject:[Person personWithAge:3]];
    printf("%s", [NSString stringWithFormat:@"尾部追加一个节点 \n%@\n\n", list].UTF8String);
    
    [list insertObject:[Person personWithAge:2] atIndex:1];
    printf("%s", [NSString stringWithFormat:@"插入到链表两个节点之间 \n%@\n\n", list].UTF8String);
    
    [list insertObject:[Person personWithAge:0] atIndex:0];
    printf("%s", [NSString stringWithFormat:@"插入到链表头部 \n%@\n\n", list].UTF8String);
    
    [list removeFirstObject];
    printf("%s", [NSString stringWithFormat:@"删除头节点 \n%@\n\n", list].UTF8String);
    
    [list removeObjectAtIndex:1];
    printf("%s", [NSString stringWithFormat:@"删除链表两个节点之间的节点 \n%@\n\n", list].UTF8String);
    
    [list removeLastObject];
    printf("%s", [NSString stringWithFormat:@"删除尾节点 \n%@\n\n", list].UTF8String);
    
    [list removeAllObjects];
    printf("%s", [NSString stringWithFormat:@"删除链表唯一的节点 \n%@\n\n", list].UTF8String);
}

void compareLinkedListAndLinkedCircleList() {
    NSUInteger testCount = 50000;
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedCircleList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:0];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeFirstObject];
        }
        NSLog(@"双向循环链表操作头节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:0];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeFirstObject];
        }
        NSLog(@"双向链表操作头节点");
    }];
    
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedCircleList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeLastObject];
        }
        NSLog(@"双向循环链表操作尾节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeLastObject];
        }
        NSLog(@"双向链表操作尾节点");
    }];
    
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedCircleList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 2];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 2];
        }
        NSLog(@"双向循环链表操作 index = 总节点数*0.25 节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 2];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 2];
        }
        NSLog(@"双向链表操作 index = 总节点数*0.25 节点");
    }];
    
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedCircleList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count * 0.75];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count * 0.75];
        }
        NSLog(@"单双向循环链表操作 index = 总节点数*0.75 节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count * 0.75];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count * 0.75];
        }
        NSLog(@"双向链表操作 index = 总节点数*0.75 节点");
    }];
    
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedCircleList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 1];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 1];
        }
        NSLog(@"双向循环链表操作中间节点");
    }];
    [JKRTimeTool teskCodeWithBlock:^{
        JKRBaseList *array = [JKRLinkedList new];
        for (NSUInteger i = 0; i < testCount; i++) {
            [array insertObject:[NSNumber numberWithInteger:i] atIndex:array.count >> 1];
        }
        for (NSUInteger i = 0; i < testCount; i++) {
            [array removeObjectAtIndex:array.count >> 1];
        }
        NSLog(@"双向链表操作中间节点");
    }];
}

void useLinkedCircleList() {
    JKRLinkedCircleList *list = [JKRLinkedCircleList new];
    for (NSUInteger i = 1; i <= 41; i++) {
        [list addObject:[NSNumber numberWithInteger:i]];
    }
    NSLog(@"%@", list);
    
    JKRLinkedListNode *node = list->_first;
    while (list.count) {
        node = node.next;
        node = node.next;
        printf("%s ", [[NSString stringWithFormat:@"%@", node.object] UTF8String]);
        [list removeObject:node.object];
        node = node.next;
    }
    printf("\n");
}

void testHashMap_LinkedList() {
    NSMutableArray *allStrings = allFileStrings();
    
    [JKRTimeTool teskCodeWithBlock:^{
        NSMutableDictionary *map = [NSMutableDictionary new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        NSLog(@"NSMutableDictionary 计算不重复单词数量和出现次数 %zd", map.count);
        NSLog(@"NSMutableDictionary 计算单词出现的次数NSObject: %@", map[@"NSObject"]);
        NSLog(@"NSMutableDictionary 计算单词出现的次数include: %@", map[@"include"]);
        NSLog(@"NSMutableDictionary 计算单词出现的次数return: %@", map[@"return"]);
        
        __block NSUInteger allCount = 0;
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            allCount += [map[obj] integerValue];
            [map removeObjectForKey:obj];
        }];
        
        NSLog(@"NSMutableDictionary 累加计算所有单词数量 %zd", allCount);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashMap_LinkedList *map = [JKRHashMap_LinkedList new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        NSLog(@"JKRHashMap_LinkedList 计算不重复单词数量和出现次数 %zd", map.count);
        NSLog(@"JKRHashMap_LinkedList 计算单词出现的次数NSObject: %@", map[@"NSObject"]);
        NSLog(@"JKRHashMap_LinkedList 计算单词出现的次数include: %@", map[@"include"]);
        NSLog(@"JKRHashMap_LinkedList 计算单词出现的次数return: %@", map[@"return"]);
        
        __block NSUInteger allCount = 0;
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            allCount += [map[obj] integerValue];
            [map removeObjectForKey:obj];
        }];
        
        NSLog(@"JKRHashMap_LinkedList 累加计算所有单词数量 %zd", allCount);
    }];
}

void testStack() {
    [JKRTimeTool teskCodeWithBlock:^{
        JKRStack *stack = [JKRStack new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [stack push:[NSNumber numberWithInteger:i]];
        }
        
        while (stack.count) {
            [stack pop];
        }
    }];
}

void testQueue() {
    [JKRTimeTool teskCodeWithBlock:^{
        JKRQueue *queue = [JKRQueue new];
        for (NSUInteger i = 0; i < 10000; i++) {
            [queue enQueue:[NSNumber numberWithInteger:i]];
        }
        
        while (queue.count) {
            NSLog(@"%@", queue.deQueue);
        }
    }];
}

