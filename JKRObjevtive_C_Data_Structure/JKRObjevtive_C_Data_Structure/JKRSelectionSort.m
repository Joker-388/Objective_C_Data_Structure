//
//  JKRSelectionSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/30.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRSelectionSort.h"

@implementation JKRSelectionSort

- (void)sort {
    for (NSUInteger end = _array.count - 1; end > 0; end--) {
        NSUInteger maxIndex = 0;
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self compareWithIndex0:maxIndex index1:begin] != NSOrderedDescending) {
                maxIndex = begin;
            }
        }
        [self swapWithIndex0:maxIndex index1:end];
    }
}

@end
