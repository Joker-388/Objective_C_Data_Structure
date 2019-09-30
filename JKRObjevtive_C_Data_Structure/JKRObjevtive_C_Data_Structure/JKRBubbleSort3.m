//
//  JKRBubbleSort3.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/30.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBubbleSort3.h"

@implementation JKRBubbleSort3

/// 优化尾部排好序的算法
- (void)sort {
    for (NSUInteger end = _array.count - 1; end > 0; end--) {
        NSUInteger sortedIndex = 1;
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self compareWithIndex0:begin index1:begin - 1] == NSOrderedAscending) {
                [self swapWithIndex0:begin index1:begin - 1];
                sortedIndex = begin;
            }
        }
        end = sortedIndex;
    }
}

@end
