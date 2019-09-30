//
//  JKRBubbleSort1.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBubbleSort1.h"

@implementation JKRBubbleSort1

/// 不带优化的冒泡排序
- (void)sort {
    for (NSUInteger end = _array.count - 1; end > 0; end--) {
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self compareWithIndex0:begin index1:begin - 1] == NSOrderedAscending) {
                [self swapWithIndex0:begin index1:begin - 1];
            }
        }
    }
}

@end
