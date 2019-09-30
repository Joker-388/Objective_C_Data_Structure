//
//  JKRBubbleSort2.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/30.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBubbleSort2.h"

@implementation JKRBubbleSort2

/// 优化已经排好序的算法，对于尾部
- (void)sort {
    for (NSUInteger end = _array.count - 1; end > 0; end--) {
        BOOL sorted = true;
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self compareWithIndex0:begin index1:begin - 1] == NSOrderedAscending) {
                [self swapWithIndex0:begin index1:begin - 1];
                sorted = false;
            }
        }
        if (sorted) break;
    }
}

@end
