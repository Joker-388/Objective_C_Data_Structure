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
#import "JKRHashMap.h"
#import "JKRHashSet.h"
#import "JKRTreeMap.h"
#import "JKRTreeSet.h"
#import "JKRBinaryHeap.h"
#import "JKRArray.h"

NSString * getRandomStr() {
    char data[6];
    for (int i = 0; i < 6; i++) data[i] = (char)((i ? 'a' : 'A') + (arc4random_uniform(26)));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    return string;
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
    
    NSLog(@"\n二叉树高度: %zd", tree.height);
    
    NSLog(@"\n二叉树节点个数: %zd", tree.count);
    /// 前序 7 4 2 1 3 5 9 8 11 10 12
    NSLog(@"\n前序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypePreorder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypePreorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];
    
    /// 后序 1 3 2 5 4 8 10 12 11 9 7
    NSLog(@"\n后序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypePostorder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypePostorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];
    
    /// 中序 1 2 3 4 5 7 8 9 10 11 12
    NSLog(@"\n中序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypeInorder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypeInorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];
    
    /// 层序 7 4 9 2 5 8 11 1 3 10 12
    NSLog(@"\n层序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypeLevelOrder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypeLevelOrder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@11]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];
    
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

void check(BOOL pass, NSString *errorString) {
    if (!pass) {
        NSLog(@"!!! 发现错误 !!! :%@", errorString);
    }
}

void testHashMapAndTreeMap() {
    NSMutableArray *allStrings = allFileStrings();
    
    __block NSUInteger hashMapCount = 0;
    __block NSUInteger treeMapCount = 1;
    __block NSUInteger treeSetCount = 2;
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashMap *map = [JKRHashMap new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        hashMapCount = map.count;
        NSLog(@"JKRHashMap 计算不重复单词数量和出现次数 %zd", map.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashSet *set = [JKRHashSet new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        treeMapCount = set.count;
        NSLog(@"JKRHashSet 计算不重复单词数量和出现次数 %zd", set.count);
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
        treeMapCount = map.count;
        NSLog(@"NSMutableDictionary 计算不重复单词数量和出现次数 %zd", map.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        NSMutableSet *set = [NSMutableSet new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        treeMapCount = set.count;
        NSLog(@"NSMutableSet 计算不重复单词数量和出现次数 %zd", set.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRTreeMap *map = [JKRTreeMap new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        treeMapCount = map.count;
        NSLog(@"JKRTreeMap 计算不重复单词数量和出现次数 %zd", map.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRTreeSet *set = [JKRTreeSet new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        treeSetCount = set.count;
        NSLog(@"JKRTreeSet 计算不重复单词数量 %zd", set.count);
    }];
    
    check(hashMapCount == treeMapCount && treeMapCount == treeSetCount, @"计算不重复单词数量结果不一致！");
    
    
//    JKRHashMap *map = [JKRHashMap new];
//    [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSNumber *count = map[obj];
//        if (count) {
//            count = [NSNumber numberWithInteger:count.integerValue+1];
//        } else {
//            count = [NSNumber numberWithInteger:1];
//        }
//        map[obj] = count;
//    }];
//    hashMapCount = map.count;
//    NSLog(@"JKRHashMap 计算不重复单词数量和出现次数 %zd", map.count);
//
//    __block NSUInteger allCount = 0;
//    [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        allCount += [map[obj] integerValue];
//        [map removeObjectForKey:obj];
//    }];
//    
//    NSLog(@"HashMap 累加计算所有单词数量 %zd", allCount);
//    
//    check(allCount == allStrings.count, @"统计所有单词出现的数量和错误！");
//    check(map.count == 0, @"哈希表没有清空！");
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
        JKRHashMap *map = [JKRHashMap new];
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
    [list removeAllObjects];
    NSLog(@"Remove all \n%@", list);
}

void testCirleList() {
    JKRBaseList *list = [JKRLinkedCircleList new];
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
    [list removeAllObjects];
    NSLog(@"Remove all \n%@", list);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testBinarySearchTree();
//        testAVLTree();
//        testRedBlackTree();
//        compareTrees();
//        testHashMapAndTreeMap();
//        testBinaryHeap();
//        testTopN();
        
//        testArray();
//        testDynamicArray();
//        compareArrayListAndSingleLinkedList();
        
//        testSingleCirleList();
//        compareSingleLinkedListAndSingleCircleLinkedList();
//        useSingleCircleList();
        testLinkedList();
//        testCirleList();
    }
    return 0;
}
