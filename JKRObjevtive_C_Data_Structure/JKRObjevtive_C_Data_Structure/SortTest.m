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

@implementation SortTest

- (void)runTest {
    JKRArrayList *numbers = [NSNumber jkr_tailAsAscendingOrderArrayWithMin:0 max:10000 disorderCount:7000];

    [self testSorts:numbers Sorts:[[JKRBubbleSort1 alloc] init], [[JKRBubbleSort2 alloc] init],[[JKRBubbleSort3 alloc] init], [[JKRSelectionSort alloc] init], [[JKRHeapSort alloc] init], nil];
}

- (void)testSorts:(JKRArrayList *)array Sorts:(JKRSort *)firstSort, ... {
    va_list args;
    va_start(args, firstSort);
    
    NSMutableArray *sorts = [NSMutableArray array];
    
    for (JKRSort *sort = firstSort; sort; sort = va_arg(args, JKRSort *)) {
        JKRArrayList *numbers = [array copy];
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
