//
//  SortTest.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/30.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "SortTest.h"
#import "NSNumber+JKRDataStructure.h"
#import "JKRSort.h"
#import "JKRBubbleSort1.h"
#import "JKRBubbleSort2.h"
#import "JKRBubbleSort3.h"
#import "JKRSelectionSort.h"
#import "JKRHeapSort.h"
#import "JKRInsertionSort1.h"
#import "JKRInsertionSort2.h"
#import "JKRInsertionSort3.h"
#import "JKRMergeSort.h"
#import "JKRQuickSort.h"
#import "JKRShellSort.h"
#import "JKRArray.h"
#import "JKRCountingSort.h"
#import "TestSortModel.h"
#import "JKRRadixSort1.h"
#import "JKRRadixSort2.h"

@implementation SortTest

- (void)runTest {
//    JKRArray *array = [JKRArray arrayWithLength:100];
//    for (id obj in array) {
//
//    }
    
//    {
//        JKRArrayList<NSNumber *> *list = [JKRArrayList array];
//        for (NSInteger i = 0; i < 100; i++) {
//            [list addObject:[NSNumber numberWithInteger:i]];
//        }
//        for (NSNumber *num in list) {
//            NSLog(@"%@", num);
//        }
//    }
//    NSLog(@"--------------------");
//    {
//        JKRArrayList<NSNumber *> *list = [JKRArrayList array];
//        for (NSInteger i = 0; i < 10; i++) {
//            [list addObject:[NSNumber numberWithInteger:i]];
//        }
//        for (NSNumber *num in list) {
//            NSLog(@"%@", num);
//        }
//    }
//    NSLog(@"--------------------");
//    {
//        JKRArrayList<NSNumber *> *list = [JKRArrayList array];
//
//        for (NSNumber *num in list) {
//            NSLog(@"%@", num);
//        }
//    }
//    NSLog(@"--------------------");
//    {
//        JKRArrayList<NSNumber *> *list = [JKRArrayList array];
//        for (NSInteger i = 0; i < 3; i++) {
//            [list addObject:[NSNumber numberWithInteger:i]];
//        }
//        for (NSNumber *num in list) {
//            NSLog(@"%@", num);
//        }
//    }
//    NSLog(@"--------------------");
//    {
//        JKRArrayList<NSNumber *> *list = [JKRArrayList array];
//
//        for (NSNumber *num in list) {
//            NSLog(@"%@", num);
//        }
//    }
    
//    JKRArrayList *numbers = [NSNumber jkr_tailAsAscendingOrderArrayWithMin:0 max:1000 disorderCount:700];
    JKRArrayList<NSNumber *> *numbers = [NSNumber jkr_randomArrayWithCount:100000 min:0 max:1000000];
    
//    JKRArrayList<NSNumber *> *numbers = [JKRArrayList array];
////    int nums[] = {7,3,5,8,6,7,4,5};
//    int nums[] = {126,69,593,23,6,89,54,8};
//    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
//        printf("%d ", nums[i]);
//        [numbers addObject:[NSNumber numberWithInt:nums[i]]];
//    }
    
    [self testSorts:numbers Sorts:
     //     [[JKRBubbleSort3 alloc] init],
     //     [[JKRSelectionSort alloc] init],
     //     [[JKRInsertionSort1 alloc] init],
     //     [[JKRInsertionSort2 alloc] init],
     //     [[JKRInsertionSort3 alloc] init],
     [[JKRHeapSort alloc] init],
     [[JKRMergeSort alloc] init],
     [[JKRQuickSort alloc] init],
     [[JKRShellSort alloc] init],
     [[JKRCountingSort alloc] init],
     [[JKRRadixSort1 alloc] init],
     [[JKRRadixSort2 alloc] init],
     nil];
}

- (NSInteger)randomFrom:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from)));
}

- (void)testSorts:(JKRArrayList<NSNumber *> *)array Sorts:(JKRSort *)firstSort, ... {
    va_list args;
    va_start(args, firstSort);
    
    NSMutableArray *sorts = [NSMutableArray array];
    
    for (JKRSort<NSNumber *> *sort = firstSort; sort; sort = va_arg(args, JKRSort *)) {
        JKRArrayList<NSNumber *> *numbers = [array copy];
        [sort sortWithArray:numbers];
        [sorts addObject:sort];
        [self checkWithPass:[NSNumber jkr_isAscendingOrder:numbers] errorString:@"** 排序失败 **"];
    }
    
    va_end(args);
    
    [sorts sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [sorts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}

- (void)checkWithPass:(BOOL)pass errorString:(NSString *)errorString {
    if (!pass) {
        NSLog(@"!!! 发现错误 !!! :%@", errorString);
    }
}

@end
